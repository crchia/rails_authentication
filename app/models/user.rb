class User < ApplicationRecord
  # this hashes and salts the password using bcrypt gem
  has_secure_password

  # validate the presence of the following fields
  validates_presence_of :username, :email, :password_digest
  validates :email, uniqueness: true
  validates :username, uniqueness: true
end
