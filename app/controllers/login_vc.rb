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

    Connection.login(login_textField.text, pwd_textField.text) do |response|
      if response.ok?
        user = User.new
        user.save_token(login_textField.text, pwd_textField.text)
        goToMain(sender)
      else
        ViewUtils.showMessage(Constants.MSG_USER_PWD_INVALID)
      end
    end
  end
  # IB - End

  def goToMain(sender)
    performSegueWithIdentifier("goToMain", sender: sender)
  end
end