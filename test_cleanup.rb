require 'sqlite3'
require 'pry'

DATABASE = SQLite3::Database.new("data_for_testing.db")

DATABASE.execute("DELETE FROM locations WHERE city = 'Orlando FL'")
DATABASE.execute("DELETE FROM categories WHERE genre = 'sci fi'")
DATABASE.execute("DELETE FROM products WHERE author = 'Me'")
