class Connection

  def self.login(username, password, &block)
    authStr = username + ":" + password
    authData = authStr.dataUsingEncoding(NSUTF8StringEncoding)
    authValue = "Basic " + authData.base64Encoding

    headers = {
        'Authorization' => authValue
    }

    BW::HTTP.get(Constants.API_ENDPOINT_USERS, { headers: headers } ) do |response|
      block.call(response)
    end
  end
end