require 'minitest/autorun'
require 'sqlite3'
require 'pry'
DATABASE = SQLite3::Database.new("data_for_testing.db")
# require_relative 'db_setup.rb'
require_relative "category.rb"
require_relative "location.rb"
require_relative "product.rb"

class WarehouseTest < Minitest::Test

  # def setup
  #   DATABASE.execute("DELETE FROM categories")
  #   DATABASE.execute("DELETE FROM locations")
  #   DATABASE.execute("DELETE FROM products")
  # end

  # assert equal(expected, actual)

  def test_product_creation
    new_product = Product.new({'isbn' => 15679, 'title' => 'A Good Book', 'author' => 'Me', 'description' => 'trade paperback', 'cost' => 1.99, 'price' => 5.99, 'quantity' => 10, 'category_id' => 3, 'location_id' => 2})
    x = new_product.insert
    assert_kind_of(Integer, x)
    # DATABASE.execute("DELETE FROM products WHERE author = 'Me'")
  end

  def test_product_deletion
    new_product = Product.new({'isbn' => 15679, 'title' => 'A Super Good Book', 'author' => 'Me', 'description' => 'trade paperback', 'cost' => 1.99, 'price' => 5.99, 'quantity' => 10, 'category_id' => 3, 'location_id' => 2})
    x = new_product.insert
    array = Product.delete(new_product.title)
    assert_equal(0, array.length)
  end


  # def test_product_save_sync_to_db
  #   x = Product.where_title_is("To Kill a Mockingbird")
  #   x.cost = 100.99
  #   x.save
  #   # y = DATABASE.execute("SELECT cost FROM products WHERE title = 'To Kill a Mockingbird'")
  #   y = Product.where_title_is("To Kill a Mockingbird")
  #   assert_equal(100.99, y.cost)
  # end

  # def test_product_search_by_author
  #   x = Product.where_author_is("Harper Lee")
  #   x.cost = 100.99
  #   x.save
  #   assert_equal()
  # end



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

  def test_location_deletion_with_existing_products
    location = Location.delete(3)
    assert_empty([], location)
  end

  def test_category_deletion_with_existing_products
    category = Category.delete(1)
    assert_empty([], category)
  end

  def test_list_all_products
    y = DATABASE.execute("SELECT * FROM products")
    assert_equal(y.length, Product.all.length)
  end

  # def test_all_products_single_genre
  #   x = DATABASE.execute("SELECT id from categories WHERE genre = 'thriller'")
  #   y = DATABASE.execute("SELECT * FROM products WHERE category_id = #{x}")
  #   z = Product.category("thriller")
  #   assert_equal(y.length, x.length)
  # end

end
