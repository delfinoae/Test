class TransactionsVC < UIViewController
  extend IB

  outlet :month_label
  outlet :back_button
  outlet :forward_button
  outlet :tableView

  @current_month = nil
  @current_year = nil
  @current_date = nil

  # IB - Start
  def didTouchBackButton(sender)
    if ( @current_month == 1 )
      @current_month = 12
      @current_year -= 1
    else
      @current_month -= 1
    end
    month_label.text = stringFromMonthYear(@current_month, @current_year)

    loadData
  end
  def didTouchForwardButton(sender)
    if ( @current_month == 12 )
      @current_month = 1
      @current_year += 1
    else
      @current_month += 1
    end
    month_label.text = stringFromMonthYear(@current_month, @current_year)

    loadData
  end
  # IB - End

  # View Life Cycle
  def viewDidLoad
    super

    # Setup label of month with actual date
    currentMonthYear()

    self.navigationController.navigationBarHidden = false

    tableView.dataSource = self
    tableView.delegate = self

    @transactions = []
    @dates = []

    loadData
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

  def tableView(tableView, viewForHeaderInSection: section)

    label = UILabel.new
    label.frame = CGRectMake(10, 8, 320, 20)
    label.font = UIFont.systemFontOfSize(12)
    label.textColor = UIColor.lightGrayColor
    label.text = tableView(tableView, titleForHeaderInSection: section)

    headerView = UIView.new
    headerView.backgroundColor = UIColor.whiteColor
    headerView.addSubview(label)

    return headerView
  end

  # Other funcs
  def currentMonthYear()
    date_formatter = NSDateFormatter.alloc.init
    date_formatter.dateFormat = "M"
    month_s = date_formatter.stringFromDate(NSDate.date)
    date_formatter.dateFormat = "yyyy"
    year_s = date_formatter.stringFromDate(NSDate.date)

    @current_month = month_s.to_i
    @current_year = year_s.to_i

    month_label.text = stringFromMonthYear(@current_month, @current_year)
  end

  def stringFromMonthYear(month, year)
    dateStr = year.to_s + "-" + month.to_s

    date_formatter = NSDateFormatter.alloc.init
    date_formatter.dateFormat = "yyyy-M"
    date = date_formatter.dateFromString(dateStr)

    @current_date = date

    date_formatter.dateFormat = "MMMM - yyyy"
    dateString = date_formatter.stringFromDate(date)
    return dateString.sub("-", "de")
  end

  def loadData()
    @transactions = []
    @dates = []
    tableView.reloadData()

    Connection.hasInternet() do |hasInternet|
      if ( hasInternet )
        Transaction.request(@current_date) do |trans, dates|
          @transactions = trans
          @dates = dates
          tableView.reloadData()
        end
      else
        Transaction.all(@current_date) do |trans, dates|
          @transactions = trans
          @dates = dates
          tableView.reloadData()
        end
      end
    end
  end
end