require 'pry'
require 'sqlite3'
require_relative 'db_setup.rb'
require_relative 'category.rb'
require_relative 'location.rb'
require_relative 'product.rb'

require 'sinatra'

get "/" do
  erb :homepage, :layout => :framework
end

get "/products"
  erb :products, :layout => :framework
end

get "/categories"
  erb :categories, :layout => :framework
end

get "/locations"
  erb :locations, :layout => :framework
end