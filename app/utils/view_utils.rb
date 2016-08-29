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

  def self.monthStringFromDate(date)
    date_formatter = NSDateFormatter.alloc.init
    date_formatter.dateFormat = "M"
    dateString = date_formatter.stringFromDate(date)
    return dateString
  end

  def self.yearStringFromDate(date)
    date_formatter = NSDateFormatter.alloc.init
    date_formatter.dateFormat = "yyyy"
    dateString = date_formatter.stringFromDate(date)
    return dateString
  end

  def self.lastDayStringFromDate(date)
    date_formatter = NSDateFormatter.alloc.init
    date_formatter.dateFormat = "M"
    monthString = date_formatter.stringFromDate(date)

    date_formatter.dateFormat = "yyyy"
    yearString = date_formatter.stringFromDate(date)

    if ( monthString.to_i == 2 )
      if ( yearString.to_i % 400 == 0 )
        return 29.to_s
      elsif ( ( yearString.to_i % 4 == 0 ) && ( yearString.to_i % 100 != 0 ) )
        return 29.to_s
      else
        return 28.to_s
      end
    elsif ( monthString.to_i <= 7 )
      if ( monthString.to_i % 2 == 0 )
        return 30.to_s
      else
        return 31.to_s
      end
    else
      if ( monthString.to_i % 2 == 0 )
        return 31.to_s
      else
        return 30.to_s
      end
    end
  end

end