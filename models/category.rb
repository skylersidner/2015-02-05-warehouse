#---------------------------------------------------------
# Class: Category
# Facilitates management of the categories (genres) assigned to our products.
#
# Attributes:
# @id     - Integer (Primary Key) in categories table (automatically assigned)
# @genre  - String: the gener name (e.g., 'thriller')
#
# Public Methods:
# #insert
# .all  
# .delete 
#---------------------------------------------------------
class Category
  # include Driver
  attr_reader :id
  attr_accessor :genre
  
  extend Class_Methods
  
  def initialize(options)
    @id = options["id"]
    @genre = options["genre"]
  end

  #---------------------------------------------------------
    # Public: #insert
    # Inserts new instantiation to the database
    #
    # Parameters: None
    #
    # Returns: The id value of new record.
    #
    # State Changes: Creates a new category in the database.
  #---------------------------------------------------------
  def insert 
    
    DATABASE.execute("INSERT INTO categories (genre) VALUES ('#{@genre}')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end

  #---------------------------------------------------------
    # Public: .delete
    # Deletes a single genre if no products are assigned to it
    #
    # Parameter: location_id
    #
    # Returnss: None
    #
    # State Changes: Deletes genre
  #---------------------------------------------------------
  def self.delete(id_to_remove)
    #taking one record in the db and deleting it
    x = DATABASE.execute("SELECT category_id FROM products WHERE category_id = #{id_to_remove}")
    if x.length == 0
      DATABASE.execute("DELETE FROM categories WHERE id = #{id_to_remove}")
    else
      DATABASE.execute("SELECT * FROM products WHERE category_id = #{id_to_remove}")
    end
  end
  
end