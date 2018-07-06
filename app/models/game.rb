class Game < ApplicationRecord
	validates :game_point, presence: true

  belongs_to :team
end
