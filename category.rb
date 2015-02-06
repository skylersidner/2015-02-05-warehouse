class Category
  include Manage
  
  attr_reader :id
  attr_accessor :genre
  
  def initialize(options)
    @id = options[:id]
    @genre = options[:genre]
  end
  
end