

module Class_Methods
  
  def all(table)
    results = DATABASE.execute("SELECT * FROM '#{table}'")
    
    results_as_objects = []

    results.each do |x|
      results_as_objects << self.new(x)
    end
    results_as_objects
  end
  
  
  
end