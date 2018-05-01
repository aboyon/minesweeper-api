class Game < ApplicationRecord
  belongs_to :user
  has_many :squares
  scope :for_user, ->(user) { where(:user => user) }

  after_create :build_grid
  validates :rows, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :cols, :presence => true, :numericality => {:only_integer => true, :greater_than => 0 }
  validates :bombs, :presence => true, :numericality => { :only_integer => true, :greater_than => 0, :less_than => :matrix_size }

  private

    def matrix_size
      rows * cols
    end

    def build_grid
      rows.times do |row|
        cols.times do |col|
          squares.create(:x => row, :y => col)
        end
      end

      squares.shuffle.take(bombs).map(&:become_a_bomb!)
    end

end
