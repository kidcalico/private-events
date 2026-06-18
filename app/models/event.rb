class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :invites, foreign_key: :attended_event_id
  has_many :attendees, through: :invites

  # def self.past
  #   where("date < ?", Time.now)
  # end

  # def self.upcoming
  #   where("date >= ?", Time.now)
  # end

  scope :past, -> { where("date < ?", Time.now) }
  scope :upcoming, -> { where("date >= ?", Time.now) }
  enum :visibility, { open: 0, invite_only: 1 }
end
