class Square < ApplicationRecord
  belongs_to :game

  def near_to_bomb?
    bombs > 0
  end

  def contiguous
    contigious_coords = contiguous_map.map do |coord|
      if coord[0].between?(0, game.cols - 1) && coord[1].between?(0, game.rows - 1)
        "(x = #{coord[0]} AND y = #{coord[1]})"
      end
    end
    Square.where(contigious_coords.compact.join(' OR '))
      .where(:game_id => game_id, :bomb => false)
  end

  def reveal!
    return if revealed? || game.terminated?
    update_column(:revealed, true)
    [self].tap { |revealed|
      if bomb?
        game.over!
      elsif !near_to_bomb?
        revealed << reveal_contiguous(contiguous)
      end
    }.flatten
  end

  def become_a_bomb!
    contiguous.update_all('bombs = bombs + 1')
    update_attributes(:bomb => true, :bombs => -1)
  end

  private

    def reveal_contiguous(contiguous_squares)
      [].tap do |list|
        contiguous_squares.reject(&:revealed?).each do |square|
          square.update_column(:revealed, true)
          list << square
          unless square.near_to_bomb?
            list += reveal_contiguous(square.contiguous)
          end
        end
      end
    end

    def contiguous_map
      [
        [x - 1, y - 1], # left down
        [x, y - 1],     # down
        [x + 1, y - 1], # right down
        [x - 1, y],     # left
        [x + 1, y],     # right
        [x - 1, y + 1], # left up
        [x, y + 1],     # up
        [x + 1, y + 1]  # right up
      ]
    end
end
