class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users

  scope :pending, -> { where(started_at: nil) }
  scope :in_progress, -> { where.not(started_at: nil).where(finished_at: nil) }

  serialize :go_fish, GoFish

  def pending?
    started_at.blank?
  end

  def play_round(current_player, target_player, rank)
    go_fish.play_round(current_player, target_player, rank)
    save!
  end

  def start
    game = GoFish.new(names: users.map(&:name), player_count: player_count)
    game.start_game
    update(started_at: Time.now)
    update(go_fish: game)
  end
end
