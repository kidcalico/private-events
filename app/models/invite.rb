class Invite < ApplicationRecord
  belongs_to :attended_event
  belongs_to :attendee
end
