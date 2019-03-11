class User < ApplicationRecord
#user ERD has many articles
  has_many :articles
#this method converts the user email in lowercase before hittig the database
  before_save { self.email = email.downcase }
# vlaidates database username, checks for unique username and checks for case sensitive username and gives min and max required
  validates :username, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximum: 15 }
  # vlaidates database email, checks for unique email, checks case sensitive email and max require.  
  # REGEX- validates email address via regular expressions.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end