require 'bcrypt'
class User < ApplicationRecord
  include BCrypt
  has_secure_password
     
  #Defining associations
  has_many :articles

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
