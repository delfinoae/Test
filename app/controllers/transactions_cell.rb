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

    if (transaction.amount_cents > 0)
      amount_label.textColor = UIColor.greenColor
      if (transaction.paid)
        status_label.text = "recebi"
      else
        status_label.text = "não recebi"
      end
    else
      amount_label.textColor = UIColor.redColor
      if (transaction.paid)
        status_label.text = "paguei"
      else
        status_label.text = "não paguei"
      end
    end
  end
end