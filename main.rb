require 'sqlite3'
require_relative 'db_setup.rb'
require_relative "categories"
require_relative "locations"
require_relative "products"
require_relative "module"
include Manage


puts "-" * 40
puts "Welcome to the Fantastic Books Warehouse."
puts "Choose an action from the list below:"
users_choice = 0

until users_choice == 7 do
puts
puts "-" * 40
puts "PRODUCT MANAGEMENT"
puts "1. Add a new product"
puts "2. Edit a product (e.g., change product category, update quantity, etc.)"
puts "3. Delete a product"
puts "4. Show products (e.g., by title, by category, or by location, etc.)"
puts "-" * 40
puts "LOCATION MANAGEMENT"
puts "5. Add a new location"
puts "6. Delete a location"
puts "-" * 40
puts "7. Exit"
puts

users_choice = gets.chomp.to_i
# *****
if users_choice == 1
  #run the code that creates a new event
  puts "Enter the date of your event:"
  date = gets.chomp.to_s
  puts "Enter the name of the restaurant:"
  restaurant = gets.chomp.to_s
  puts "Enter the names of the people who are attending this event. (Enter the names as a comma-separated list.)"
  attendees = gets.chomp
  # attendees = names.split(", ")
  binding.pry
  dc.create_new_event(date, restaurant, *attendees)
elsif users_choice == 2
  puts "Enter the amount of the meal:"
  amt = gets.chomp.to_i
  puts "Enter the amount of the tip. (Example for a 20% tip, enter 20.)"
  tip = gets.chomp.to_i
  dc.reconcile(amt, tip)
elsif users_choice == 3
  puts "Current club members include:" 
  dc.members.each do |name, amt|
    puts "#{name}"
  end
elsif users_choice == 4
  #add a new member to the club
  puts "Who would you like to add to your dinner club:"
  name = gets.chomp.to_s
  dc.add_member(name)
  puts "Current members now include:"
  dc.members.each do |name, amt|
    puts "#{name}"
  end
elsif users_choice == 5 
  puts "Please come again!"
end




binding.pry



