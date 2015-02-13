require 'pry'
require 'sqlite3'

require_relative 'class_module.rb'


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


get "/l_all" do
  @all = Location.all("locations")
  erb :"displays/l_display"
end

get "/l_new" do
  erb :"locations/l_new"
end

get "/l_confirm" do
  @city = params["city"]
  erb :"locations/l_confirm"
end

get "/l_create" do
  @l = Location.new(params)
  @l.insert
  @all = [@l]
  erb :"locations/l_create"
end


get "/c_all" do
  @all = Category.all("categories")
  erb :"displays/c_display"
end

get "/c_new" do
  erb :"categories/c_new"
end

get "/c_confirm" do
  @genre = params["genre"]
  erb :"categories/c_confirm"
end

get "/c_create" do
  @c = Category.new(params)
  @c.insert
  @all = [@c]
  erb :"categories/c_create"
end


get "/p_all" do
  @all = Product.all("products")
  erb :"displays/p_display"
end


get "/p_new" do
  erb :"products/p_new"
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


get "/p_search" do
  erb :"products/p_search"
end

get "/p_narrow" do
  results = Product.where_field_is(params["search"])
  
  @results_array = []
  results.each do |hash|
    @results_array << hash[params["search"]]
  end
  @results_array.uniq!
  @results_array.sort!
  @search = params["search"]
  erb :"products/p_narrow"
end

get "/p_results" do
  @all = Product.search(params["search"], params["choice"])
  @search = params["search"]
  @choice = params["choice"]
  erb :"products/p_results"
end

before "/*" do
  if params[:splat] == "p_identified" || params[:splat] == "p_edit" || params[:splat] == "p_delete"
    binding.pry
    @all = Product.search("id", params["id"])
    erb :"/products/params[:splat]"
  end
end

get "/p_identified" do
  erb :"/products/p_identified"
end

get "/p_edit" do
  erb :"/products/p_edit"
end

get "/p_delete" do
  erb :"/products/p_delete"
end


#binding.pry