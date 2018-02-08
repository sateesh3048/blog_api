module ExceptionHandler
  extend ActiveSupport::Concern
  
  # Define custome error subclasses - rescue catches `Standard Errors`
  class AuthenticationError < StandardError;end
  class MissingToken < StandardError;end
  class InvalidToken < StandardError;end

  included do 
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
  end

  private
  
  # JSON response with message; Status code 404 - not found
  def record_not_found(e)
    json_errors({message: e.message}, :not_found)
  end
  
  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_errors({message: e.message}, :unprocessable_entity)
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_errors({message: e.message}, :unauthorized)
  end
end