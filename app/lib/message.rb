class Message
  def self.not_found(record = "record")
    "Sorry #{record} not found"
  end

  def self.invalid_token
    'Your session got expired. Please Login Back!'
  end

  def self.missing_token
    'Missing Token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.account_not_created
    'Account could not created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end
end