class Game < ApplicationRecord
  belongs_to :user
  has_many :squares
  scope :for_user, ->(user) { where(:user => user) }

  after_create :build_grid
  validates :rows, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :cols, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :bombs, :presence => true, :numericality => {:only_integer => true, :greater_than => 0, :less_than => :matrix_size }

  def coords(x,y)
    squares.find_by(:x => x, :y => y)
  end

  def over!
    update_attributes(:over => true)
    squares.update_all(:revealed => true)
  end

  def terminated?
    @terminated ||= (squares.where(:revealed => false).count == bombs)
  end

  private

    def matrix_size
      rows * cols
    end

    def build_grid
      rows.times do |row|
        cols.times do |col|
          squares.create(:x => col, :y => row)
        end
      end

      squares.shuffle.take(bombs).map(&:become_a_bomb!)
    end

end
