class Location
  attr_reader :id
  attr_accessor :city
  
  def initialize(options)
    @id = options[:id]
    @city = options[:city]
  end

  def insert
    DATABASE.execute("INSERT INTO locations (city) VALUES ('#{@city}')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end
  
  def self.all
    DATABASE.execute("SELECT * FROM locations")
  end
  
  def self.delete(city)
    x = DATABASE.execute(SELECT city FROM products WHERE location_id = '#{city}')
    if x.length == 0
      DATABASE.execute(DELETE FROM locations WHERE city = '#{city}')
    else
      DATABASE.execute(SELECT city FROM locations WHERE location_id = '#{city}')
    end
  end

end