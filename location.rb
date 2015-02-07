class Location
  attr_reader :id
  attr_accessor :city
  
  def initialize(options)
    @id = options["id"]
    @city = options["city"]
  end

  def insert
    DATABASE.execute("INSERT INTO locations (city) VALUES ('#{@city}')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end
  
  def self.all
    DATABASE.execute("SELECT * FROM locations")
  end
  
  def self.delete(id_to_remove)
    x = DATABASE.execute("SELECT location_id FROM products WHERE location_id = #{id_to_remove}")
    if x.length == 0
      DATABASE.execute("DELETE FROM locations WHERE id = #{id_to_remove}")
    else
      DATABASE.execute("SELECT * FROM products WHERE location_id = #{id_to_remove}")
    end
  end

end