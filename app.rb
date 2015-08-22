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
BOOTSTRAP_CDN = 'https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css'


# ##############################
# Routing Section
# ##############################
after AFTER_ROUTING_MATCHER do
  redirect to('/')
end

get '/' do
  slim :index, locals: {restaurants: Restaurant.all}
end

get '/restaurant' do
  content_type :json
  restaurants = Restaurant.all
  puts restaurants;
  restaurants.to_json
end

get '/create' do
  redirect to('/') if Restaurant.count >= 10
  # create new Restaurant
  # (1)
  restaurant = Restaurant.create(
    rid: 'the-counter-palo-alto',
    active: true ,
    cover: "burgers.jpg",
    categories: [3, 18],
    created_at: "2015-07-08T03:09:10Z",
    images_count: 0,
    name: "The Counter (Palo alto)",
    slogan: "Custom Built Burgers",
    open: true
  )
  restaurant.store.create(
    id: "the-counter-palo-alto-13-1221124455-374008333",
    as: "2580 W El Camino Real",
    dt: false,
    fn: "(650) 948-2308",
    hi: false,
    loc: [
      -122.1124455,
      37.4008333
    ]
  )
  # (2)
  restaurant = Restaurant.create(
    rid: 'the-counter-mountain-view',
    active: true ,
    cover: "burgers.jpg",
    categories: [3, 18],
    created_at: "2015-07-08T03:09:10Z",
    images_count: 0,
    name: "The Counter (Palo alto)",
    slogan: "Custom Built Burgers",
    open: true
  )
  restaurant.store.create(
    id: "the-counter-palo-alto-13-1221124455-374008333",
    as: "2580WElCaminoReal",
    dt: false,
    fn: "(650)948-2308",
    hi: false,
    loc: [
       -122.1124455,
        37.4008333
    ]
  )
  # (3)
  restaurant = Restaurant.create(
    rid: 'the-counter-mountain-view',
    active: true ,
    cover: "burgers.jpg",
    categories: [3, 18],
    created_at: "2015-07-08T03:09:10Z",
    images_count: 0,
    name: "TheCounter(MountainView)",
    slogan: "Custom Built Burgers",
    open: true
  )
  restaurant.store.create(
    id: "the-counter-palo-alto-13-1221124455-374008333",
    as: "2580 W El Camino Real",
    dt: false,
    fn: "(650) 948-2308",
    hi: false,
    loc: [
      -122.1124455,
      37.4008333
    ]
  )
  # (4)
  restaurant = Restaurant.create(
    rid: 'the-counter-mountain-view',
    active: true ,
    cover: "burgers.jpg",
    categories: [3, 18],
    created_at: "2015-07-08T03:09:10Z",
    images_count: 0,
    name: "TheCounter(MountainView)",
    slogan: "Custom Built Burgers",
    open: true
  )
  restaurant.store.create(
    id: "the-counter-palo-alto-13-1221124455-374008333",
    as: "2580 W El Camino Real",
    dt: false,
    fn: "(650) 948-2308",
    hi: false,
    loc: [
      -122.1124455,
      37.4008333
    ]
  )
  #(5)
  restaurant = Restaurant.create(
    rid: 'the-counter-los-angeles',
    active: true ,
    cover: "burgers.jpg",
    categories: [3, 18],
    created_at: "2015-07-08T03:09:10Z",
    images_count: 0,
    name: "The Counter (Los Angeles)",
    slogan: "Custom Built Burgers",
    open: true
  )
  restaurant.store.create(
    id: "the-counter-palo-alto-13-1221124455-374008333",
    as: "2580 W El Camino Real",
    dt: false,
    fn: "(650) 948-2308",
    hi: false,
    loc: [
      -122.1124455,
      37.4008333
    ]
  )
  puts "RESTAURANT: #{restaurant.to_json}"
end

get '/delete_all' do
  Restaurant.delete_all
end

# ##############################
# Template Section
# ##############################
__END__

@@layout
html
  head
    <!-- Latest compiled and minified CSS -->
    link rel="stylesheet" href=BOOTSTRAP_CDN
    style
      | body { padding-top: 50px; }
      | ul.nav { background-color: #FFF; }
  body
    ul.nav.nav-tabs.nav-justified.navbar-fixed-top
      li
        a href='/' index
      li
        a href='/create' create
      li
        a href='/delete_all' delete_all
#    .container
#      p Restaurant.count=[#{Restaurant.count}]
#      == yield

@@index
- restaurants.all.each do |restaurant|
  h4 = "id=#{restaurant.id}"
  p = "rid=#{restaurant.rid}"
  p = "cover=#{restaurant.cover}"
  p = "category: #{restaurant.categories}"
  p = "created_at: #{restaurant.created_at}"
  p = "images_count: #{restaurant.images_count}"
  p = "name: #{restaurant.name}"
  p = "slogan: #{restaurant.slogan}"
  p = "open: #{restaurant.open}"
  p = "store: #{restaurant.store.to_json}"

