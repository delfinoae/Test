class TransactionsVC < UIViewController
  extend IB

  outlet :month_label
  outlet :back_button
  outlet :forward_button
  outlet :tableView

  # IB - Start
  def didTouchBackButton(sender)

  end
  def didTouchForwardButton(sender)

  end
  # IB - End

  # View Life Cycle
  def viewDidLoad
    super
    self.navigationController.navigationBarHidden = false
  end

  # TableView datasource
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CellTransaction"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    return 2
  end
end