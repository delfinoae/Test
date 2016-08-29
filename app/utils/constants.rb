class Constants < NSObject

  @@MSG_USER_PWD_INVALID = "E-mail ou senha estão incorretos"

  @@API_ENDPOINT = "https://api.organizze.com.br/rest/v2"
  @@API_ENDPOINT_USERS = @@API_ENDPOINT + "/users"
  @@API_ENDPOINT_TRANSACTIONS = @@API_ENDPOINT + "/transactions"
  @@API_ENDPOINT_CATEGORIES = @@API_ENDPOINT + "/categories"


  def self.MSG_USER_PWD_INVALID
    return @@MSG_USER_PWD_INVALID
  end

  def self.API_ENDPOINT
    return @@API_ENDPOINT
  end

  def self.API_ENDPOINT_USERS
    return @@API_ENDPOINT_USERS
  end

  def self.API_ENDPOINT_TRANSACTIONS
    return @@API_ENDPOINT_TRANSACTIONS
  end

  def self.API_ENDPOINT_CATEGORIES
    return @@API_ENDPOINT_CATEGORIES
  end

end