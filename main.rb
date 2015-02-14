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

get "/l_confirm_create" do
  @city = params["city"]
  erb :"locations/l_confirm_create"
end

get "/l_create_confirmed" do
  @l = Location.new(params)
  @l.insert
  @all = [@l]
  erb :"locations/l_create_confirmed"
end


get "/c_all" do
  @all = Category.all("categories")
  erb :"displays/c_display"
end

get "/c_new" do
  erb :"categories/c_new"
end

get "/c_confirm_create" do
  @genre = params["genre"]
  erb :"categories/c_confirm_create"
end

get "/c_create_confirmed" do
  @c = Category.new(params)
  @c.insert
  @all = [@c]
  erb :"categories/c_create_confirmed"
end


get "/p_all" do
  @all = Product.all("products")
  erb :"displays/p_display"
end

get "/p_new" do
  erb :"products/p_new"
end

get "/p_confirm_create" do
  @all = []
  @all << Product.new(params)
  erb :"products/p_confirm_create"
end

get "/p_create_confirmed" do
  @p = Product.new(params)
  @p.insert
  @all = [@p]
  erb :"products/p_create_confirmed"
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
  erb :"/products/p_results"
end

get "/p_identified" do
  @all = Product.search("id", params["id"])
  if params["e_d"] == "delete"
    erb :"/products/p_confirm_delete"
  else
    erb :"/products/p_edit"
  end
end


get "/p_delete" do
  Product.delete(params["id"])
  erb :"/products/p_delete_confirmed"
end


get "/p_confirm_edit" do
  binding.pry
  @all_old = Product.search("id", params["id"])
  @all = []
  @all << Product.new(params)
  erb :"/products/p_confirm_edit"
end

get "/p_edit_confirmed" do
  @all = Product.new(params)
  @all.save
  erb :"/products/p_edit_confirmed"
end

#binding.pry