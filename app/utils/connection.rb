class Connection

  def self.login(username, password, &block)
    authStr = username + ":" + password
    authData = authStr.dataUsingEncoding(NSUTF8StringEncoding)
    authValue = "Basic " + authData.base64Encoding

    App::Persistence['authValue'] = authValue

    headers = {
        'Authorization' => authValue
    }

    BW::HTTP.get(Constants.API_ENDPOINT_USERS, { headers: headers } ) do |response|
      block.call(response)
    end
  end

  def self.hasInternet(&block)
    BubbleWrap::HTTP.get(Constants.CONN_IP_TEST) do |response|
      if response.ok?
        block.call(true)
      else
        block.call(false)
      end
    end
  end
end