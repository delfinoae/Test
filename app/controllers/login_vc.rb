class LoginVC < UIViewController
  extend IB

  outlet :login_textField
  outlet :pwd_textField
  outlet :login_button

  # IB - Start
  def didTouchLoginButton(sender)
    if ( login_textField.text.length == 0 ||
        pwd_textField.text.length == 0)
      ViewUtils.showMessage(Constants.MSG_USER_PWD_INVALID)
      return false
    end

    Connection.hasInternet() do |hasInternet|
      if ( hasInternet )
        Connection.login(login_textField.text, pwd_textField.text) do |response|
          if response.ok?
            user = User.new
            user.save_token(login_textField.text, pwd_textField.text)
            goToMain(sender)
          else
            ViewUtils.showMessage(Constants.MSG_USER_PWD_INVALID)
          end
        end
      else
        if ( User.load_token == nil )
          ViewUtils.showMessage(Constants.MSG_USER_CONNECT_INTERNET)
          return
        end

        if ( login_textField.text == User.load_username && pwd_textField.text == User.load_token )
          goToMain(sender)
        else
          ViewUtils.showMessage(Constants.MSG_USER_PWD_INVALID)
        end
      end
    end
  end
  # IB - End

  # View Life Cycle
  def viewDidLoad
    super

    self.navigationController.navigationBarHidden = true

    login_button.layer.cornerRadius = 15.0
  end

  # Actions
  def goToMain(sender)
    performSegueWithIdentifier("goToMain", sender: sender)
  end
end