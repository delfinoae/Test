class ViewUtils < NSObject

  def self.showMessage(msg)
    alert = UIAlertView.new
    alert.message = msg
    alert.addButtonWithTitle("OK")
    alert.show
  end

  # Method from https://gist.github.com/eliaskg/2856127
  def self.colorFromHexString(color_string, alpha = 1.0)
    red   = color_string[0,2].hex
    green = color_string[2,2].hex
    blue  = color_string[4,2].hex

    red_percent   = red.to_f / 255
    green_percent = green.to_f / 255
    blue_percent  = blue.to_f / 255

    return UIColor.colorWithRed(red_percent, green:green_percent, blue:blue_percent, alpha:alpha)
  end

end