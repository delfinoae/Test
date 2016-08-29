class ViewUtils < NSObject

  def self.showMessage(msg)
    alert = UIAlertView.new
    alert.message = msg
    alert.addButtonWithTitle("OK")
    alert.show
  end

end