class LoginVC < UIViewController
  extend IB

  outlet :login_textField
  outlet :pwd_textField
  outlet :login_button

  # IB - Start
  def didTouchLoginButton(sender)
    if ( validateLogin )
      goToMain(sender)
    end
  end
  # IB - End

  def validateLogin()
    true
  end

  def goToMain(sender)
    self.performSegueWithIdentifier("goToMain", sender: sender)
  end
end