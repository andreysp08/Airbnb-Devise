puts "criando . . . "
require 'faker'
require 'geocoder'
require 'open-uri'

name = Faker::Book.title

address = Faker::Address.community
results = Geocoder.search(address)

description = Faker::Lorem.sentence()

latitude = results.first.coordinates.first
longitude = results.first.coordinates.last

pricing = rand(30..120)
avaliability = rand(1..5)

# Defining user owner of flat
users = User.all
users_ids = []
users.each { |user| users_ids << user.id }
user_id = users_ids.sample


puts "name: #{name}"
puts "Address: #{address}"
puts "Description: #{description}"
puts "[Lat, long]: #{results.first.coordinates}"
puts "Pricing: #{pricing}"
puts "Avaliability: #{avaliability}"
puts "Owner (email): #{User.find(user_id).email}"

flat = Flat.create!(name: name, address: address, description: description, latitude: latitude, longitude: longitude, pricing: pricing, avaliability: avaliability, user_id: user_id)
3.times do |i|
    image_url = 'https://loremflickr.com/300/300/house,room,bathroom'
    file = URI.open(image_url)
    flat.photos.attach(io: file, filename: "image#{i}.jpg", content_type: 'image/jpg')
    puts "image#{i}.jpg uploaded!!!"
end

puts "criando!"
