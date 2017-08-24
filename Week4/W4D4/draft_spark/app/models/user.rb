class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: 'Password can\'t be blank' }
  validates :password, length: { minimum: 6, allow_nil: true }
  before_validation :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    if user && BCrypt::Password.new(user.password_digest).is_password?(password)
      return user
    else
      # Meaning user is not found OR password incorrect
      # Later we probably want to be more specific and return a message,
      # saying user does not exist or password incorrect
      nil
    end
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    # @session_token = nil
    # We want to generate a new one, not set it to nil
    self.session_token = User.generate_session_token
    self.save

    # Also need to return the session_token
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(user_password)
    @password = user_password

    # This must be a create, not 'new', so that it is in our params?
    self.password_digest = BCrypt::Password.create(self.password)
  end
end
