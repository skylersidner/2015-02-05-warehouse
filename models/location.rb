#---------------------------------------------------------
# Class: Location
# Facilitates management of the warehouse locations (city) to store our products.
#
# Attributes:
# @id     - Integer (Primary Key) in locations table (automatically assigned)
# @city   - String: the city name and state abbreviation (e.g., 'Omaha NE')
#
# Public Methods:
# #insert
# .all  
# .delete 
#---------------------------------------------------------

class Location
  attr_reader :id
  attr_accessor :city
  
  extend Class_Methods
  
  def initialize(options)
    @id   = options["id"]
    @city = options["city"]
  end
  
  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation to the database
  #
  # Parameters: None
  #
  # Returns: The id value of the new record.
  #
  # State Changes: Creates a new record in the database.
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO locations (city) VALUES ('#{@city}')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end

  #---------------------------------------------------------
  # Public: .delete
  # Deletes a single location if no products are assigned to it
  #
  # Parameters: location_id
  #
  # Returns: None
  #
  # State Changes: Deletes a location in the database.
  #---------------------------------------------------------
  def self.delete(id_to_remove)
    x = DATABASE.execute("SELECT location_id FROM products WHERE location_id = #{id_to_remove}")
    if x.length == 0
      DATABASE.execute("DELETE FROM locations WHERE id = #{id_to_remove}")
    else
      DATABASE.execute("SELECT * FROM products WHERE location_id = #{id_to_remove}")
    end
  end
    

end