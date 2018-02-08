class AuthenticateUser
  def initialize(email, password, expires_in)
    @email = email
    @password = password
    @expires_in = expires_in
  end

  #Service entry point
  def call
    JsonWebToken.encode({user_id: user.id}, @expires_in) if user
  end

  private

  attr_reader :email, :password
  
  # Verify the user credentials
  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end