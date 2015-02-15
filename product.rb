#---------------------------------------------------------
# Class: Product
# For adding records to the products table and storing record data.
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
# .search
# .delete
#---------------------------------------------------------
class Product
  attr_reader :id
  attr_accessor :isbn, :title, :author, :description, :cost, :price, :quantity, :category_id, :location_id

  extend Class_Methods

  def initialize(options)
    @id           = options["id"]
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
  # Parameters: None
  #
  # Returns: The ID value of the new record.
  #
  # State Changes: Creates a new product in the database.
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO products (isbn, title, author, description, cost, price, quantity, category_id, location_id) VALUES ('#{@isbn}', '#{@title}', '#{@author}', '#{@description}', '#{@cost}', '#{@price}', '#{@quantity}', '#{category_id}', '#{location_id}')")
    @id = DATABASE.last_insert_row_id
  end

  #---------------------------------------------------------
  # Public: #save
  # Saves product record information from an object to the database.
  #
  # Parameters: None
  #
  # Returns: None
  #
  # State Changes: Updates data in the database.
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
  # Public: .search
  # Searches the database for product records.
  #
  # Parameters:
  # field_name  - String: The name of field in the database.
  # choice      - String/Integer: The corresponding values for that field.
  #
  # Returns: An array of Product objects matching the search.
  #
  # State Changes: None
  #---------------------------------------------------------
  def self.search(field_name, choice)
    if choice.is_a?(String)
      results = DATABASE.execute("SELECT * FROM products WHERE #{field_name}='#{choice}'")
    else
      results = DATABASE.execute("SELECT * FROM products WHERE #{field_name}=#{choice}")
    end
      results_as_objects = []

    results.each do |x|     # x is a hash
      # this loops through and creates an array of objects
      results_as_objects << self.new(x)
    end
    results_as_objects
  end

  #---------------------------------------------------------
  # Public: .delete
  # Removes a product record from the database, based on its ID
  #
  # Parameter:
  # id  - Integer: The ID of the product record to be removed.
  #
  # Returns: None
  #
  # State Changes: Removes the product record from the database.
  #---------------------------------------------------------
  def self.delete(id)
      DATABASE.execute("DELETE FROM products WHERE id = #{id}")
  end

end
