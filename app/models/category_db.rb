class CategoryDB  < NanoStore::Model

  attribute :id
  attribute :name
  attribute :color
  attribute :parent_id

  def self.add_category(category)
    CategoryDB.create(:id => category.id, :name => category.name, :color => category.color, :parent_id => category.parent_id)
  end

  def self.add_categories(categories)
    CategoryDB.cleanDatabase
    categories.each do |category|
      CategoryDB.add_category(category)
    end
  end

  def self.cleanDatabase()
    CategoryDB.delete
  end

end