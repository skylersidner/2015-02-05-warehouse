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


end
# binding.pry

=begin
  def test_student_has_questions
    student = Student.new({name: "Blake"})
    x = Question.new({student_id: student.id, question: "What up?"})
      # student.questions.length > 0
      # refute_equal([], student.questions)
    assert_equal(1, student.questions.length)
  end

  def test_student_creation
    student = Student.new({name: "Jenny"})
    x = DATABASE.execute("SELECT name FROM students WHERE id =    
                        #{student.id}")
    added_student = x[0]
    assert_equal(1, x.length)
    assert_equal("Jenny", added_student["name"])
  end

  def test_list_all_students
    DATABASE.execute("DELETE FROM students")
    s1 = Student.new({name: "Liz"})
    s2 = Student.new({name: "Barb"})
    assert_equal(2, Student.all.length)
    # ("SELECT * FROM question WHERE student_id = #{@id}")
  end

end
=end