
# Class: Class_Methods
# Extracted class methods to be used by multiple classes.
# (Product, Location, Category)
#
# Attributes: None (module)
#
# Public Methods:
# #all
module Class_Methods
  
  # Public: #all
  # Enables a class to return all records from its corresponding table.
  #
  # Parameters:
  # table - String: The name of the table to be listed.
  #
  # Returns: An array of objects.
  #
  # State Changes: None
  def all(table)
    results = DATABASE.execute("SELECT * FROM '#{table}'")
    
    results_as_objects = []

    results.each do |x|
      results_as_objects << self.new(x)
    end
    results_as_objects
  end
  
  
  
end