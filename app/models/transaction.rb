class Transaction
  PROPERTIES = [:id, :desc, :date, :paid, :amount_cents, :total_installments, :installment,
                :recurring, :account_id, :category_id, :payee_id, :notes, :attachments_count,
                :credit_card_id, :credit_card_invoice_id, :paid_credit_card_id, :paid_credit_card_invoice_id,
                :oposite_transaction_id, :oposite_account_id, :created_at, :updated_at, :category]

  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(attributes = {})
    attributes.each { |key, value|
      # I have to use this IF, because "description" field cannot be used in objc
      if ( key == "description" )
        self.send("desc=", value)
      else
        self.send("#{key}=", value)
      end
    }
  end

  def self.request(&block)
    BW::HTTP.get(Constants.API_ENDPOINT_TRANSACTIONS, { headers: Transaction.headers }) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        transactions = json.map { |transaction| Transaction.new(transaction) }

        Category.request() do |data|
          categories = data
          transactions = Transaction.setup(categories, transactions)
          dates = Transaction.datesFrom(transactions)
          TransactionDB.add_transactions(transactions)
          block.call(transactions, dates)
        end

      end
    end
  end

  def self.all(&block)
    transactions = []
    dates = []

    transactions_db = TransactionDB.all()
    if ( transactions_db != nil )
      transactions = self.parseDB(transactions_db)
      dates = Transaction.datesFrom(transactions)
    end
    block.call(transactions, dates)
  end

  def self.parseDB(transactions_db)
    categories = Category.parseDB(CategoryDB.all())
    transactions = []
    for trans in transactions_db
      attr = {
          "id" => trans.id,
          "desc" => trans.desc,
          "date" => trans.date,
          "paid" => trans.paid,
          "amount_cents" => trans.amount_cents,
          "category_id" => trans.category_id,
          "category" => categories.find { |cat| cat.id == trans.category_id }
      }
      transaction = Transaction.new(attr)
      transactions << transaction
    end

    transactions = Transaction.setup(categories, transactions)
    return transactions
  end

  def self.transactionsByPeriod(period, &block)
    # TO DO
  end

  def self.headers
    {
        'Authorization' => App::Persistence['authValue']
    }
  end

  def setCategory(category)
    self.send("category=", category)
  end

  def self.setup(categories, transactions)
    transactions.each do |transaction|
      category = categories.find { |category| category.id == transaction.category_id }
      transaction.setCategory(category)
    end

    # Order by date
    transactions = transactions.sortedArrayUsingComparator(lambda do |first, second|
        first.date.compare(second.date)
      end
    )

    return transactions
  end

  def self.datesFrom(transactions)
    dates = []

    transactions.each do |trans|
      dates << trans.date
    end
    return dates.uniq
  end
end