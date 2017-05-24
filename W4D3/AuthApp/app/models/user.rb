require 'securerandom'
require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank"}
  validates :password, length: { minimum: 8, allow_nil: true }
  before_validation :ensure_session_token

  attr_reader :password


  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    if user && Password.new(user.password_digest).is_password?(password)
      user
    else
      nil
    end
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = Password.create(new_password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
