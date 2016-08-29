class TransactionsCell < UITableViewCell
  extend IB

  outlet :description_label
  outlet :category_label
  outlet :color_view
  outlet :amount_label
  outlet :status_label

  def setup(transaction)
    color_view.layer.cornerRadius = 5.0

    description_label.text = transaction.desc
    amount_label.text = "R$ " + transaction.amount_cents.to_s
    category_label.text = transaction.category.name
    color_view.backgroundColor = ViewUtils.colorFromHexString(transaction.category.color)

    date_formatter = NSDateFormatter.alloc.init
    date_formatter.dateFormat = "yyyy-MM-dd"
    date = date_formatter.dateFromString(transaction.date)

    if (transaction.amount_cents > 0)
      amount_label.textColor = UIColor.greenColor
      if (transaction.paid)
        status_label.text = "recebi"
      else
        status_label.text = "não recebi"

        if ( date.compare(NSDate.date) )
          self.backgroundColor = UIColor.colorWithRed(255, green: 241, blue: 0, alpha: 0.10)
        end
      end
    else
      amount_label.textColor = UIColor.redColor
      if (transaction.paid)
        status_label.text = "paguei"
      else
        status_label.text = "não paguei"

        if ( date.compare(NSDate.date) )
          self.backgroundColor = UIColor.colorWithRed(255, green: 241, blue: 0, alpha: 0.10)
        end
      end
    end
  end
end