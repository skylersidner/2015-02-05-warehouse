# Goes in Product class
def display_attr
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
      x = DATABASE.execute("SELECT genre from categories WHERE id = '#{self.send(a)}'")
      x = x[0]
      x = x["genre"]
      front_spacer = " " * (12 - a.length)
      back_spacer = " " * (50 - (("#{x}".length) + ("#{self.send(a)}".length + 2)))
      puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "#{self.send(a)}" + "(#{x})"
      
    elsif a == "location_id"
      x = DATABASE.execute("SELECT city from locations WHERE id = '#{self.send(a)}'")
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

# Goes in main.rb (or driver)
def format_many(array_of_objects)
  count = 0
  array_of_objects.each do |x|
    count += 1
    puts "Product #{count}:"
    x.display_attr
  end
end

############################################
# Optional factored method for display.  Incomplete. 2/8/09
def display_menu(x)
  count = 0
  x.each do |y|
    count += 1
    puts "#{count}. #{y}"
  end
end

main_menu = ["PRODUCT MANAGEMENT", "GENRE MANAGEMENT", "LOCATION MANAGEMENT"]
product_menu = ["Add a new product", 
                "Edit a product (e.g., change product genre, update quantity, change location, etc.)", 
                "Delete a product", 
                "Show products (e.g., by title, by location, or by genre, etc.)"]
genre_menu = ["Add a new genre", "Delete a genre"]
location_menu = ["Add a new location", "Delete a location"]


puts "Welcome to the FANTASTIC BOOKS Inventory Management Tool."
puts "Choose an action from the list below:"
puts "You can exit at any time by entering '9'."

display_menu(main_menu)
users_choice = gets.chomp.to_i

final_choice = 0
until final_choice <= 3 && final_choice >= 1
  if users_choice == 1
    display_menu(product_menu)
    final_choice = gets.chomp.to_i
  elsif users_choice == 2
    display_menu(genre_menu)
    final_choice = gets.chomp.to_i
  elsif users_choice == 3
    display_menu(location_menu)
    final_choice = gets.chomp.to_i
  else
    puts "That is not a valid choice."
  end
end

################################################
# Alternate code for search methods;
# Must call format_many(array) in driver for this.  They now return arrays of objects.

def self.where_title_is(title)
  results = DATABASE.execute("SELECT * FROM products WHERE title = '#{title}'")
  convert_to_objects(results)
end

def self.where_author_is(author)
  results = DATABASE.execute("SELECT * FROM products WHERE author = '#{author}'")
  convert_to_objects(results)
end

def self.where_id_is(record_id)
  results = DATABASE.execute("SELECT * FROM products WHERE id = #{record_id}")
  convert_to_objects(results)
end

########################################################
# Refactoring the object creation code out since we're using it everywhere.
# Need to figure out where it needs to go, but I think Product class?

def convert_to_objects(results)
  results_as_objects = []

  results.each do |x|
    results_as_objects << self.new(x)
  end
  results_as_objects
end
  