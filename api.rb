require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'mongoid'
Mongoid.load!('./mongoid.yml')

# ##############################
# Mongoid Document Section
# ##############################
class Restaurant
  include Mongoid::Document
  field :title,   type: String
  field :article, type: String
  embeds_many :store
  field :id,   type: String
  field :active, type: Boolean
  field :categories, type: Array # list of integers
  field :cover, type: String
  field :created_at, type: String  # date
  field :foundation_date, type: Date
  field :images_count, type: Fixnum
  field :name, type:String
  field :slogan, type:String
  embeds_many :store
  field :open, type: Boolean

end

class Store
  include Mongoid::Document
  field :name
  field :comment
  embedded_in :restaurants
end

# ##############################
# Constants
# ##############################
AFTER_ROUTING_MATCHER = /\/\w+/

# ##############################
# Routing Section
# ##############################
after AFTER_ROUTING_MATCHER do
  redirect to('/')
end

get '/' do
  puts "GET all"
  content_type :json
  restaurants = Restaurant.all
  puts restaurants;
  restaurants.to_json
end

get '/:id' do
  puts "@@@ GET one #{params[:id]}"
  params = JSON.parse request.body.read
  restaurant = Restaurant.find(params[:id])
  puts restaurant
  content_type :json
  restaurant.to_json
end

put '/:id' do
  puts "PUT"
  id = params[:id]
  puts id
  params = JSON.parse request.body.read
  restaurants = Restaurant.all
  puts restaurants.to_json
  puts "PARAMS=#{params.to_json}"
  restaurant = Restaurant.find(id)
  puts "Current = #{restaurant.to_json}"
  restaurant["name"] = params["name"] if params["name"]!=nil
  restaurant["slogan"] = params["slogan"] if params["slogan"]!=nil
  restaurant["categories"] = params["categories"] if params["categoreis"]!=nil
  restaurant["created_at"] = params["created_at"] if params["created_at"]!=nil
  restaurant["foundation_date"] = params["foundation_date"] if params["foundation_date"]!=nil
  restaurant["cover"] = params["cover"] if params["cover"]!=nil
  restaurant["active"] = params["active"] if params["active"]!=nil
  restaurant.save
end

delete '/:id' do
  puts "DELETE"
  id = params[:id]
  puts id
  restaurant = Restaurant.find(id)
  puts restaurant.to_json
  restaurant.DELETE
  null
end

