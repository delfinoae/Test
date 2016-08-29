class TransactionsVC < UIViewController
  extend IB

  outlet :month_label
  outlet :back_button
  outlet :forward_button
  outlet :tableView

  # IB - Start
  def didTouchBackButton(sender)
    # TO DO
  end
  def didTouchForwardButton(sender)
    # TO DO
  end
  # IB - End

  # View Life Cycle
  def viewDidLoad
    super
    self.navigationController.navigationBarHidden = false

    tableView.dataSource = self
    tableView.delegate = self

    @transactions = []
    @dates = []

    Connection.hasInternet() do |hasInternet|
      if ( hasInternet )
        Transaction.request() do |trans, dates|
          @transactions = trans
          @dates = dates
          tableView.reloadData()
        end
      else
        Transaction.all() do |trans, dates|
          @transactions = trans
          @dates = dates
          tableView.reloadData()
        end
      end
    end
  end

  # TableView datasource
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CellTransaction"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      TransactionsCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    date = @dates[indexPath.section]
    transactions = @transactions.select { |trans| trans.date == date}
    transaction = transactions[indexPath.row]
    if ( transaction != nil )
      cell.setup(transaction)
    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    date = @dates[section]

    transactions = @transactions.select { |trans| trans.date == date}
    return transactions.count
  end

  def numberOfSectionsInTableView(tableView)
    if ( @dates != nil )
      return @dates.count
    end
  end

  def tableView(tableView, titleForHeaderInSection: section)
    date_formatter = NSDateFormatter.alloc.init
    date_formatter.dateFormat = "yyyy-MM-dd"
    date = date_formatter.dateFromString(@dates[section])

    date_formatter.dateFormat = "dd/M - EEEE"
    dateString = date_formatter.stringFromDate(date)

    if ( dateString != nil )
      dateString = dateString.sub('-feira', '')
    end

    return dateString
  end
end