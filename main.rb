require 'pry'
require 'sqlite3'
require_relative 'db_setup.rb'
require_relative 'category.rb'
require_relative 'location.rb'
require_relative 'product.rb'

require 'sinatra'

get "/" do
  erb :homepage
end

get "/products" do
  erb :products
end

get "/categories" do
  erb :categories
end

get "/locations" do
  erb :locations
end

get "/l_create" do
  erb :"locations/l_create"
end

get "/c_create" do
  erb :"categories/c_create"
end

get "/p_new" do
  erb :"products/p_new"
end

get "/l_index" do
  @all = Location.all
  erb :"locations/l_index"
end

get "/c_index" do
  @all = Category.all
  erb :"categories/c_index"
end

get "/p_index" do
  @all = Product.all
  erb :"/products/p_index"
end

get "/p_confirm" do
  @isbn         = params["isbn"]
  @title        = params["title"]
  @author       = params["author"]
  @description  = params["description"]
  @cost         = params["cost"]
  @price        = params["price"]
  @quantity     = params["quantity"]
  @category_id  = params["category_id"]
  @location_id  = params["location_id"]
  erb :"products/p_confirm"
end

get "/p_create" do
  @p = Product.new(params)
  @p.insert
  @all = [@p]
  erb :"products/p_create"
end




#binding.pry