require 'pry'
require 'sqlite3'
require 'hirb'
require_relative 'db_setup.rb'
require_relative 'category.rb'
require_relative 'location.rb'
require_relative 'product.rb'

=begin
users_choice = 0

until users_choice == 9 do
  sleep(2)
  system "clear"
  puts "*" * 90
  puts "Welcome to the FANTASTIC BOOKS Inventory Management Tool."
  puts "Choose an action from the list below:"
  puts
  puts "-" * 90
  puts "PRODUCT MANAGEMENT"
  puts "1. ADD a new product"
  puts "2. EDIT a product (e.g., change product genre, update quantity, change location, etc.)"
  puts "3. DELETE a product"
  puts "4. VIEW products (e.g., by title, by location, or by genre, etc.)"
  puts "-" * 90
  puts "GENRE MANAGEMENT"
  puts "5. ADD a new genre"
  puts "6. DELETE a genre"
  puts "-" * 90
  puts "LOCATION MANAGEMENT"
  puts "7. ADD a new location"
  puts "8. DELETE a location"
  puts "-" * 90
  puts "9. EXIT"
  puts "*" * 90
  users_choice = gets.chomp.to_i

#****************************************************************************************
  attributes_list = ["isbn", "title", "author", "description", "cost",
                     "price", "quantity", "category_id", "location_id"]
  attributes_hash = {"isbn" => nil, "title" => nil, "author" => nil,
                     "description" => nil, "cost" => nil, "price" => nil,
                     "quantity" => nil, "category_id" => nil, "location_id" => nil}

  if users_choice == 1
    puts ''
    attributes_list.each do |x|
      puts "Enter the #{x}:"
      user_input = gets.chomp
      # if user_input?(Integer)
      #   user_input = user_input
      # else user_input = ''
      attributes_hash[x] = user_input
    end
      x = Product.new(attributes_hash)
      x.insert
      puts "#{x.title} has now been added to the database:"
      x.display

  elsif users_choice == 2
    puts ''
    puts "How would you like to search for the item to edit:"
    puts "1. Author"
    puts "2. Title"
    user_input = gets.chomp.to_i
      if user_input == 1
        puts "Enter the Author (Example: 'Harper Lee')"
        author = gets.chomp.to_s
        result = Product.where_author_is(author)
        puts "Which of these titles by #{author} would you like to edit? (e.g., 'Kill Shot')"
        title = gets.chomp.to_s
        book_to_edit = Product.where_title_is(title)
      elsif user_input == 2
        puts "Enter the Title (Example: 'To Kill a Mockingbird')"
        title = gets.chomp.to_s
        book_to_edit = Product.where_title_is(title)
      end
        puts "Great! Let's edit #{book_to_edit.title}."
        puts "Which field would you like to edit?"
        puts "1. Author"
        puts "2. Title"
        puts "3. Description"
        puts "4. Price"
        puts "5. Cost"
        puts "6. Warehouse Location"
        puts "7. Genre"
        puts "8. Quantity"
        field_input = gets.chomp.to_i
          if field_input == 1
            puts "Current author is: #{book_to_edit.author}"
            puts "What is the new Author? (e.g., 'Harper Lee')"
            author_input = gets.chomp.to_s
            book_to_edit.author = author_input
            book_to_edit.save
            sleep(1)
            puts "Success! The new author has been saved:"
            book_to_edit.display
          elsif field_input == 2
            puts "Current title is: #{book_to_edit.title}"
            puts "What is the new Title? (e.g., 'To Kill a Mockingbird')"
            title_input = gets.chomp.to_s
            book_to_edit.title = title_input
            book_to_edit.save
            sleep(1)
            puts "Success! The new title has been saved:"
            book_to_edit.display
          elsif field_input == 3
            puts "Current description is: #{book_to_edit.description}"
            puts "What is the new Description? (e.g., 'Hardcover')"
            description_input = gets.chomp.to_s
            book_to_edit.description = description_input
            book_to_edit.save
            sleep(1)
            puts "Success! The new description has been saved:"
            book_to_edit.display
          elsif field_input == 4
            puts "Current price is: #{book_to_edit.price}"
            puts "What is the new Price? (e.g., 8.99)"
            price_input = gets.chomp.to_f
            book_to_edit.price = price_input
            book_to_edit.save
            sleep(1)
            puts "Success! The new price has been saved:"
            book_to_edit.display
          elsif field_input == 5
            puts "Current cost is: #{book_to_edit.cost}"
            puts "What is the new Cost? (e.g., 2.99)"
            cost_input = gets.chomp.to_f
            book_to_edit.cost = cost_input
            book_to_edit.save
            sleep(1)
            puts "Success! The new cost has been saved:"
            book_to_edit.display
          elsif field_input == 6
            puts "Current location is: #{book_to_edit.city}"
            puts "What is the new Warehouse location for this product? 
                 (e.g., Dallas TX)"
            city_input = gets.chomp.to_s
            x = DATABASE.execute("SELECT id from locations WHERE city =
                                 '#{city_input}'")
            x = x[0]
            x = x["id"]
            book_to_edit.location_id = x
            book_to_edit.save
            sleep(1)
            puts "Success! The new location has been saved:"
            book_to_edit.display
          elsif field_input == 7
            puts "Current genre is: #{book_to_edit.genre}"
            puts "What is the new Genre for this product? (e.g., 'horror')"
            genre_input = gets.chomp.to_s
            x = DATABASE.execute("SELECT id from locations WHERE city = 
                                 '#{city_input}'")
            x = x[0]
            x = x["id"]
            book_to_edit.category_id = x
            book_to_edit.save
            sleep(1)
            puts "Success! The new genre has been saved:"
            book_to_edit.display
          elsif field_input == 8
            puts "Current quantity is: #{book_to_edit.quantity}"
            puts "What is the new Quantity for this product? (e.g., 10)"
            quantity_input = gets.chomp.to_i
            book_to_edit.quantity
            book_to_edit.save
            sleep(1)
            puts "Success! The new quantity has been saved:"
            book_to_edit.display
          end

  elsif users_choice == 3
    puts ''
    puts "How would you like to search for the item you want to delete:"
    puts "1. Author"
    puts "2. Title"
    user_input = gets.chomp.to_i
      if user_input == 1
        puts "Enter the Author (Example: 'Harper Lee')"
        author = gets.chomp.to_s
        Product.where_author_is(author)
        puts "Which of these titles by #{author} would you like to delete? (e.g., 'Kill Shot')"
        # result.each do |x|
        #     puts "#{x[0]}: #{x[2]} by #{x[3]}"
        # end
        
        title = gets.chomp.to_s
        puts "Are you sure you want to delete #{title}? (y/n)"
        yes_no = gets.chomp.to_s.downcase
          if yes_no == "y"
          Product.delete(title)
          puts "#{title} has been deleted."
          else 
            return 9
          end
      elsif user_input == 2
        x = Product.all
        puts "Enter the Title to delete (Example: 'To Kill a Mockingbird')"
        title = gets.chomp.to_s
        result = Product.where_title_is(title)
        puts "Are you sure you want to delete #{result.title}? (y/n)"
        yes_no = gets.chomp.to_s.downcase
          if yes_no == "y"
          Product.delete(title)
          puts "#{title} has been deleted."
          end
      end

  elsif users_choice == 4
    puts ''
    puts "How would you like to view products?"
    puts "1. All products."
    puts "2. All products in a certain warehouse."
    puts "3. All products in a certain genre."
    view_input = gets.chomp.to_i
    if view_input == 1
      x = Product.all
      # x.each do |x|
      #   puts "#{x[0]}: #{x[2]}   by #{x[3]}"
      # end
    elsif view_input == 2
      puts "What warehouse location would you like to see? (e.g., 'Omaha NE')"
      city_input = gets.chomp.to_s
      x = Product.location(city_input)
        if x == []
          puts "There are no products at this location."
        else  
          puts "Products in #{city_input}:"
          x.each do |x|
            puts "#{x[0]}: #{x[2]}   by #{x[3]}"
          end
        end
    elsif view_input == 3
      puts "What genre would you like to view? (e.g., 'suspense')"
      genre_input = gets.chomp.to_s
      x = Product.category(genre_input)
      if x == []
        puts "There are no products assigned to this genre."
      else  
        puts "Products in genre: #{genre_input}:"
        x.each do |x|
          puts "#{x[0]}: #{x[2]}   by #{x[3]}"
        end
      end
    end

  elsif users_choice == 5
    puts ''
    puts "What is the name of the new genre? (e.g., 'graphic novel')"
    new_genre_input = gets.chomp.to_s
    x = Category.new({'genre' => "#{new_genre_input}"})
    x.insert
    puts "#{new_genre_input} has been added to the database."

  elsif users_choice == 6
    puts ''
    puts Category.all
    puts "What is the name of the genre you want to delete? (e.g., 'romance')"
    delete_genre_input = gets.chomp.to_s
    puts "Warning: If products are assigned to this genre, it cannot be deleted."
    results = DATABASE.execute("SELECT * FROM products INNER JOIN categories ON Products.category_id = Categories.id WHERE genre = '#{delete_genre_input}'")
    if results != []
    puts "These products are assigned to this genre:"
      results.each do |x|
        puts "#{x[0]}: #{x[2]} - #{x[11]}"
      end
    end
    x = DATABASE.execute("SELECT id FROM categories WHERE genre = '#{delete_genre_input}'")
    x = x[0]
    genre_id = x["id"]
    Category.delete(genre_id)
    if results == []
      puts "Success! #{delete_genre_input} has been deleted."
    else puts "This genre cannot be deleted until all products are re-assigned to another genre."
    end

  elsif users_choice == 7
    puts ''
    puts "What is the name of the new warehouse location? (e.g., 'Sioux City IA')"
    new_location_input = gets.chomp.to_s
    x = Location.new({'city' => "#{new_location_input}"})
    x.insert
    puts "#{new_location_input} has been added to the database."
    x.inspect

  elsif users_choice == 8
    puts ''
    puts Location.all
    puts "What is the name of the location you want to delete? (e.g., 'Sioux City IA')"
    delete_location_input = gets.chomp.to_s
    puts "Warning: If products are assigned to this location, it cannot be deleted."
    results = DATABASE.execute("SELECT * FROM products INNER JOIN locations ON Products.location_id = Locations.id WHERE city = '#{delete_location_input}'")
    if results != []
    puts "These products are assigned to this location:"
      results.each do |x|
        puts "#{x[0]}: #{x[2]} - #{x[11]}"
      end
    end
    x = DATABASE.execute("SELECT id FROM locations WHERE city = '#{delete_location_input}'")
    x = x[0]
    location_id = x["id"]
    Location.delete(location_id)
      if results == []
        puts "Success! #{delete_location_input} has been deleted."
      else puts "This location cannot be deleted until all products are re-assigned to another location."
      end

  elsif users_choice == 9
    puts "Thank you. Please come again!"
  end
end
binding.pry
=end