class Category
  # include Manage
  
  attr_reader :id
  attr_accessor :genre
  
  def initialize(options)
    @id = options["id"]
    @genre = options["genre"]
  end
  
  def insert    #insert a NEW record into db
    # If you were doing from the command line:
    # INSERT INTO students (name) VALUES ('Andrew');
    #Run in terminal Question.all
    
    # YOU MUST USE SINGLE QUOTES AROUND THE STRING INTERPOLATION:
    DATABASE.execute("INSERT INTO categories (genre) VALUES ('#{@genre}')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end
  
  def self.all
    DATABASE.execute("SELECT * FROM categories")
  end
  
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