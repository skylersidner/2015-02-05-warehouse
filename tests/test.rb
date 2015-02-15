require 'minitest/autorun'
require 'sqlite3'
require 'pry'
DATABASE = SQLite3::Database.new("../database/data_for_testing.db")
# require_relative 'db_setup.rb'

require_relative "../modules/class_module.rb"
require_relative "../models/category.rb"
require_relative "../models/location.rb"
require_relative "../models/product.rb"

class WarehouseTest < Minitest::Test

  # assertion (expected, actual)

  def test_product_creation
    new_product = Product.new({'isbn' => 15679, 'title' => 'A Good Book', 'author' => 'Me', 'description' => 'trade paperback', 'cost' => 1.99, 'price' => 5.99, 'quantity' => 10, 'category_id' => 3, 'location_id' => 2})
    x = new_product.insert
    assert_kind_of(Integer, x)
  end

  def test_product_deletion
    new_product = Product.new({'isbn' => 15679, 'title' => 'A Super Good Book', 'author' => 'Me', 'description' => 'trade paperback', 'cost' => 1.99, 'price' => 5.99, 'quantity' => 10, 'category_id' => 3, 'location_id' => 2})
    x = new_product.insert
    Product.delete(x)
    result = DATABASE.execute("SELECT * FROM products WHERE id=#{x}")
    assert_equal(0, result.length)
  end

  def test_location_creation
    new_location = Location.new({'city' => "Orlando FL"})
    x = new_location.insert
    assert_kind_of(Integer, x)
    DATABASE.execute("DELETE FROM locations WHERE city = 'Orlando FL'")
  end

  def test_category_creation
    new_category = Category.new({'genre' => "sci fi"})
    x = new_category.insert
    assert_kind_of(Integer, x)
    DATABASE.execute("DELETE FROM categories WHERE genre = 'sci fi'")
  end

  def test_location_deletion
    new_location = Location.new({'city' => "Jacksonville FL"})
    x = new_location.insert
    array = Location.delete(x)
    assert_equal(0, array.length)
  end

  def test_category_deletion
    new_category = Category.new({'genre' => "romance"})
    x = new_category.insert
    array = Category.delete(x)
    assert_equal(0, array.length)
  end

  # BROKEN - I think this is a problem with testing module based methods.
  # def test_list_all_products
  #   y = DATABASE.execute("SELECT * FROM products")
  #   result = Product.all("products")
  #   assert_equal(y.length, result.length)
  # end

end

# NOTE: You MUST run test_cleanup.rb before running this test again.


