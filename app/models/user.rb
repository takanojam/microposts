class User < ActiveRecord::Base
  before_action { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 225},
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  validates :location, absence: true,
                       on: :create
  validates :location, allow_blank: true,
                       length: { minimum: 2, maximum: 20 },
                       on: :update
    has_secure_password
end
