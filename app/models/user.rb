class User < ApplicationRecord
  # vlaidates database username, checks for unique username and checks for case sensitive username and give min and max required
  validates :username, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
end