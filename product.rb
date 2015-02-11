#---------------------------------------------------------
# Class: Product
# Products and all the things they can do
#
# Attributes:
# @isbn         - Integer:  the book's identifier
# @title        - String:   the book's title
# @author       - String:   the book's author
# @description  - String:   the book's description (book type)
# @cost         - Float:    the book's cost
# @price        - Float:    the book's sale price
# @quantity     - Integer:  number of copies in stock at a given warehouse
# @category_id  - Integer:  the book's genre (by number; cross-references categories table)
# @location_id  - Integer: the book's location (by number; cross-references locations table)
#
# Public Methods:
# #insert
# #save
# #city
# #genre
# #display
# .where_title_is  
# .where_author_is
# .where_id_is 
# .all  
# .location
# .category 
#---------------------------------------------------------
class Product
  attr_reader :id
  attr_accessor :isbn, :title, :author, :description, :cost, :price, :quantity, :category_id, :location_id

  def initialize(options)
    @isbn         = options["isbn"]
    @title        = options["title"]
    @author       = options["author"]
    @description  = options["description"]
    @cost         = options["cost"]
    @price        = options["price"]
    @quantity     = options["quantity"]
    @category_id  = options["category_id"]
    @location_id  = options["location_id"]
  end

  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation to the database
  #
  # Parameter: None
  #
  # Returns: None
  #
  # State Changes: None
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO products (isbn, title, author, description, cost, price, quantity, category_id, location_id) VALUES ('#{@isbn}', '#{@title}', '#{@author}', '#{@description}', '#{@cost}', '#{@price}', '#{@quantity}', '#{category_id}', '#{location_id}')")
    @id = DATABASE.last_insert_row_id
  end

  #---------------------------------------------------------
  # Public: #save
  # When changes are made to a Product object, this saves the changes to the database
  #
  # Parameter: None
  #
  # Returns: None
  #
  # State Changes: None
  #---------------------------------------------------------
  def save 
      attributes = []
      query_components_array = []

      instance_variables.each do |i|
        attributes << i.to_s.delete("@")
      end

      attributes.each do |a|
        value = self.send(a)
        if value.is_a?(Integer) || value.is_a?(Float)
          query_components_array << "#{a} = #{self.send(a)}"
        else
          query_components_array << "#{a} = '#{self.send(a)}'"
        end
      end

        q = query_components_array.join(", ")

      DATABASE.execute("UPDATE products SET #{q} WHERE title = '#{@title}'")
  end

  #---------------------------------------------------------
  # Public: #city
  # "Translates" between the location_id and the actual name of the city
  #---------------------------------------------------------
  def city
    DATABASE.execute("SELECT city FROM products INNER JOIN locations ON Products.location_id = Locations.id WHERE title = 'book_to_edit'")
  end

  #---------------------------------------------------------
  # Public: #genre
  # "Translates" between the category_id and the genre
  #---------------------------------------------------------
  def genre
    DATABASE.execute("SELECT genre FROM products INNER JOIN categories ON Products.category_id = Categories.id WHERE title = 'book_to_edit'")
  end

  #---------------------------------------------------------
  # Public: #display
  # Provides a user-friendly display for products
  #---------------------------------------------------------
  def display
   attributes = []
   query_components_array = []

   instance_variables.each do |i|
     attributes << i.to_s.delete("@")
   end

   attributes.each do |a|
     value = self.send(a)
     if value.is_a?(Float)
       front_spacer = " " * (12 - a.length)
       back_spacer = " " * (49 - ("#{self.send(a)}".length))
       puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "$#{self.send(a)}"
     else
       front_spacer = " " * (12 - a.length)
       back_spacer = " " * (50 - ("#{self.send(a)}".length))
       puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "#{self.send(a)}"
     end
   end
   puts "=" * 63
   return
  end

  #---------------------------------------------------------
    # Public: .where_title_is
    # Searches the Product class for a single title. 
    #
    # Parameter: title
    #
    # Returns: Single Product object with matching title (passed as argument)
  #---------------------------------------------------------
  def self.where_title_is(title)
    results = DATABASE.execute("SELECT * FROM products WHERE title = '#{title}'")
    
    results_as_objects = []
    
    results.each do |r|     # r is a hash 
      # this loops through and creates an array of objects
      results_as_objects << self.new(r) 
    end
    z = results_as_objects[0]
  end

  #---------------------------------------------------------
    # Public: .where_author_is
    # Searches the Product class for a single author. 
    #
    # Parameter: author name
    #
    # Returns: Array of hashes of various products by a single author
  #---------------------------------------------------------
  def self.where_author_is(author)
    results = DATABASE.execute("SELECT * FROM products WHERE author = '#{author}'")
    results.each do |x|
      puts "#{x[0]}: #{x[2]} by #{x[3]}   (Quantity in stock: #{7})"
    end
    #
    # results_as_objects = []
    #
    # results.each do |r|     # r is a hash
    #   # this loops through and creates an array of objects
    #   results_as_objects << self.new(r)
    # end
    # z = results_as_objects[0]
  end

  #---------------------------------------------------------
    # Public: .where_id_is
    # Searches the Product class for a single id. 
    #
    # Parameter: id
    #
    # Returns: Single Product object with matching id (passed as argument)
  #---------------------------------------------------------
  def self.where_id_is(record_id)
    results = DATABASE.execute("SELECT * FROM products WHERE id =
                               #{record_id}")
    record_details = results[0] # Hash of the record details.
    z = self.new(record_details)
  end

  #---------------------------------------------------------
  # Public: .all
  # Displays all products
  #---------------------------------------------------------
  def self.all
    x = DATABASE.execute("SELECT * FROM products")
    x.each do |x|
        puts "#{x[0]}: #{x[2]} by #{x[3]}"
    end
  end

  #---------------------------------------------------------
  # Public: .location
  # Displays all products assigned to a specific location
  #
  # Parameters: city (e.g., 'Omaha NE')
  #---------------------------------------------------------
  def self.location(city)
    x = DATABASE.execute("SELECT id from locations WHERE city = '#{city}'")
    x = x[0]
    x = x["id"]
    DATABASE.execute("SELECT * FROM products WHERE location_id = #{x}")
  end

  #---------------------------------------------------------
  # Public: .category
  # Displays all products assigned to a specific genre
  #
  # Parameters: genre name (e.g., 'thriller')
  #---------------------------------------------------------
  def self.category(genre)
    x = DATABASE.execute("SELECT id from categories WHERE genre = '#{genre}'")
    x = x[0]
    x = x["id"]
    DATABASE.execute("SELECT * FROM products WHERE category_id = #{x}")
  end

  #---------------------------------------------------------
    # Public: .delete
    # Deletes a single product 
    #
    # Parameter: title
    #
    # Returns: None
    #
    # State Changes: Deletes product
  #---------------------------------------------------------
  def self.delete(title)
      DATABASE.execute("DELETE FROM products WHERE title = '#{title}'")
  end

end
