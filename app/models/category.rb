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

  def self.all(&block)
    BW::HTTP.get(Constants.API_ENDPOINT_CATEGORIES, { headers: Category.headers }) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        categories = json.map { |category| Category.new(category) }
        block.call(categories)
      end
    end
  end

  def self.headers
    {
        'Authorization' => App::Persistence['authValue']
    }
  end
end