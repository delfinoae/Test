class TransactionDB  < NanoStore::Model
  attribute :id
  attribute :desc
  attribute :date
  attribute :paid
  attribute :amount_cents
  attribute :category_id

  def self.add_transaction(transaction)
    TransactionDB.create(:id => transaction.id, :desc => transaction.desc, :date => transaction.date,
                         :paid => transaction.paid, :amount_cents => transaction.amount_cents,
                         :category_id => transaction.category_id)
  end

  def self.add_transactions(transactions)
    TransactionDB.cleanDatabase
    transactions.each do |transaction|
      TransactionDB.add_transaction(transaction)
    end
  end

  def self.cleanDatabase()
    TransactionDB.delete
  end
end