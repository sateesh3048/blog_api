class AuthorizeApiRequest
  attr_reader :headers

  def initialize(headers = {})
    @headers = headers
  end
  
  def call
    {
      user: user
    }
  end

  private 

  def user
    begin 
      @user ||= User.find(decode_auth_token[:user_id]) if decode_auth_token
    rescue ActiveRecord::RecordNotFound => e
      raise(
        ExceptionHandler::InvalidToken,(Message.invalid_token))
    rescue Exception => e
      raise(
        ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
        ) if e.message.include?("Signature has expired")
      raise e.message
    end
  end


  #Decode authentication token
  def decode_auth_token
    p "http_auth_headers>>>http_auth_headers>>"
    p http_auth_headers
    p "*********************************"
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_headers)
  end

  # Check for token in authorization headers
  def http_auth_headers
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end

end