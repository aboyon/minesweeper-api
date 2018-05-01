class Square < ApplicationRecord
  belongs_to :game

  def become_a_bomb!
    update_column(:bomb, true)
  end
end
