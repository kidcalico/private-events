class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [ :username ]

  validates :username, presence: true, uniqueness: true

  before_save { self.username = username.downcase }

  has_many :hosted_events, dependent: :destroy, foreign_key: :host_id, class_name: "Event"
  has_many :invites, foreign_key: :attendee_id
  has_many :attended_events, through: :invites
end
