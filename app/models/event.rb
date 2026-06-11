class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :invites, foreign_key: :attended_event_id
  has_many :attendees, through: :invites

  def self.past
    where("date < ?", Time.now)
  end

  def self.upcoming
    where("date >= ?", Time.now)
  end
end
