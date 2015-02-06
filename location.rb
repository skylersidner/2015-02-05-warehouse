class Location
  attr_reader :id
  attr_accessor :city
  
  def initialize(options)
    @id = options[:id]
    @city = options[:city]
  end
  
end