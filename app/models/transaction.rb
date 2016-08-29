class Transaction
  PROPERTIES = [:id, :description, :date, :paid, :amount_cents, :total_installments, :installment,
                :recurring, :account_id, :category_id, :payee_id, :notes, :attachments_count,
                :credit_card_id, :credit_card_invoice_id, :paid_credit_card_id, :paid_credit_card_invoice_id,
                :oposite_transaction_id, :oposite_account_id, :created_at, :updated_at]

  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(attributes = {})
    attributes.each { |key, value|
      self.send("#{key}=", value) if PROPERTIES.member? key
    }
  end

  def self.all(&block)
    BW::HTTP.get(Constants.API_ENDPOINT_TRANSACTIONS, { headers: Transaction.headers }) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        transactionsData = json[:data][:transactions] || []
        transactions = transactionsData.map { |transaction| Transaction.new(transaction) }
        block.call(transactions)
      end
    end
  end

  def self.transactionsByPeriod(period, &block)
    BW::HTTP.get(Constants.API_ENDPOINT_TRANSACTIONS + "?start-date=___&end-date=___", { headers: Transaction.headers }) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        transactionsData = json[:data][:transactions] || []
        transactions = transactionsData.map { |transaction| Transaction.new(transaction) }
        block.call(transactions)
      end
    end
  end

  def self.headers
    {
        'Authorization' => App::Persistence['authValue']
    }
  end
end