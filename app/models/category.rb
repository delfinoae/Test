class Category
  PROPERTIES = [:id, :name, :color, :parent_id]

  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(attributes = {})
    attributes.each { |key, value|
      self.send("#{key}=", value)
    }
  end

  def self.request(&block)
    BW::HTTP.get(Constants.API_ENDPOINT_CATEGORIES, { headers: Category.headers }) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        categories = json.map { |category| Category.new(category) }
        CategoryDB.add_categories(categories)
        block.call(categories)
      end
    end
  end

  def self.all(&block)
    categories_db = CategoryDB.all()
    categories = self.parseDB(categories_db)
    block.call(categories)
  end

  def self.parseDB(categories_db)
    categories = []
    for cat in categories_db
      attr = {
          "id" => cat.id,
          "name" => cat.name,
          "color" => cat.color
      }
      category = Category.new(attr)
      categories << category
    end

    return categories
  end

  def self.headers
    {
        'Authorization' => App::Persistence['authValue']
    }
  end
end