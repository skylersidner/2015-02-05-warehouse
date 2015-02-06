class Product
  include Manage
  
  attr_reader :id
  attr_accessor :isbn, :title, :author, :description, :cost, :price, :quantity

  # id (PRIMARY KEY), category_id (FOREIGN KEY), and location_id (FOREIGN KEY)
  def initialize(options)
    @isbn         = options[:name]
    @title        = options[:age]
    @author       = options[:hometown]
    @description  = options[:name]
    @cost         = options[:age]
    @price        = options[:hometown]
    @quantity     = options[:name]
  end

  def transfer_product_to_another_location(qty, from_location, to_location)
  end
  
end

