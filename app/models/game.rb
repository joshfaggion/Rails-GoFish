class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users

  scope :pending, -> { where(started_at: nil) }
  scope :in_progress, -> { where.not(started_at: nil).where(finished_at: nil) }

  def pending?
    started_at.blank?
  end

  def player_count
  end
end
