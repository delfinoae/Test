class User
  def save_token(username, token)
    App::Persistence['username'] = username
    App::Persistence['token'] = token
  end

  def self.load_username
    App::Persistence['username']
  end

  def self.load_token
    App::Persistence['token']
  end

  def self.reset
    App::Persistence['username'] = nil
    App::Persistence['token'] = nil
  end
end