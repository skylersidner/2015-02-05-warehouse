class Product
  # include Manage
  
  attr_reader :id
  attr_accessor :isbn, :title, :author, :description, :cost, :price, :quantity, :category_id, :location_id

  # id (PRIMARY KEY), category_id (FOREIGN KEY), and location_id (FOREIGN KEY)
  def initialize(options)
    @isbn         = options["isbn"]
    @title        = options["title"]
    @author       = options["author"]
    @description  = options["description"]
    @cost         = options["cost"]
    @price        = options["price"]
    @quantity     = options["quantity"]
    @category_id  = options["genre"]
    @location_id  = options["city"]
  end

  # def assign_category_id(genre)
  #   # if genre.is_a?(Integer)
  #   #   query_components_array << "#{a} = #{self.send(a)}"
  #   # else
  #   #   query_components_array << "#{a} = '#{self.send(a)}'"
  #   # end
  #   d = DATABASE.execute("SELECT id FROM categories WHERE genre = '#{genre}'")
  #   @category_id = d[0]
  # end
  #
  # def assign_location_id(city)
  #   d = DATABASE.execute("SELECT id FROM locations WHERE city = '#{city}'")
  #   @location_id = d[0]
  # end

  def insert
    DATABASE.execute("INSERT INTO products (isbn, title, author, description, cost, price, quantity, category_id, location_id) VALUES ('@isbn', '@title', '@author', '@description', '@cost', '@price', '@quantity', '@category_id', '@location_id')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end

  def self.where_title_is(title)
    results = DATABASE.execute("SELECT * FROM products WHERE title = '#{title}'")
    
    results_as_objects = []
    
    results.each do |r|     # r is a hash 
      # this loops through and creates an array of objects
      results_as_objects << self.new(r) 
    end
    @objects_array = results_as_objects
  end

  def self.where_author_is(author)
    results = DATABASE.execute("SELECT * FROM products WHERE author = '#{author}'")
    
    results_as_objects = []
    
    results.each do |r|     # r is a hash 
      # this loops through and creates an array of objects
      results_as_objects << self.new(r) 
    end
    @objects_array = results_as_objects
  end

  def save 
      attributes = []

      instance_variable.each do |i|
        attributes << i.to_s.delete("@")
      end

      attributes.each do |a|
        value = self.send(a)
        if value.is_a?(Integer)
          query_components_array << "#{a} = #{self.send(a)}"
        else
          query_components_array << "#{a} = '#{self.send(a)}'"
        end
      end

        q = query_components_array.join(", ")

      DATABASE.execute("UPDATE products SET #{q} WHERE id = #{@id}")
  end
  
  def self.all
    DATABASE.execute("SELECT * FROM products")
  end

  def self.location(city)
    DATABASE.execute("SELECT * FROM products WHERE location = '#{city}'")
  end

  def self.category(genre)
    DATABASE.execute("SELECT * FROM products WHERE genre = '#{genre}'")
  end
  
  def self.delete(title)
      DATABASE.execute(DELETE FROM products WHERE title = '#{title}')
  end
  
end