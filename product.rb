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
      elsif a == "category_id"
        x = translate_id("genre")
        
        x = DATABASE.execute("SELECT genre FROM categories WHERE id = '#{self.send(a)}'")
        x = x[0]
        x = x["genre"]
        
        front_spacer = " " * (12 - a.length)
        back_spacer = " " * (50 - (("#{x}".length) + ("#{self.send(a)}".length + 2)))
        puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "#{self.send(a)}" + "(#{x})"
      
      elsif a == "location_id"
        x = DATABASE.execute("SELECT city FROM locations WHERE id = '#{self.send(a)}'")
        x = x[0]
        x = x["city"]
        front_spacer = " " * (12 - a.length)
        back_spacer = " " * (50 - (("#{x}".length) + ("#{self.send(a)}".length + 2)))
        puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "#{self.send(a)}" + "(#{x})"
      else
        front_spacer = " " * (12 - a.length)
        back_spacer = " " * (50 - ("#{self.send(a)}".length))
        puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "#{self.send(a)}"
      end
    end
    puts "=" * 63
    return
  end

  def self.where_field_is(field)
    results = DATABASE.execute("SELECT #{field} FROM products")
  end

  def self.search(field_name, choice)
    results = DATABASE.execute("SELECT * FROM products WHERE #{field_name}='#{choice}'")
    results_as_objects = []

    results.each do |x|     # x is a hash
      # this loops through and creates an array of objects
      results_as_objects << self.new(x)
    end
    results_as_objects
  end

  def self.delete(id)
      DATABASE.execute("DELETE FROM products WHERE id = #{id}")
  end

end
