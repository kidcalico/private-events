class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [ :username ]

  validates :username, presence: true, uniqueness: true

  before_save { self.username = username.downcase }

  has_many :created_events, dependent: :destroy, foreign_key: :creator_id, class_name: "Event"
end
