puts "criando . . . "
require 'faker'
require 'geocoder'
require 'open-uri'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

address = Faker::Address.community
results = Geocoder.search(address)

latitude = results.first.coordinates.first
longitude = results.first.coordinates.last

users = User.all
users_ids = []
users.each { |user| users_ids << user.id }


puts "coordenadas: #{address}"
puts "coordenadas: #{results.first.coordinates}"
puts "lat: #{latitude}, long: #{longitude}"

flat = Flat.create!(name: Faker::Book.title, address: address, description: Faker::Lorem.sentence(), latitude: latitude, longitude: longitude, pricing: rand(30..120), avaliability: 3, user_id: users_ids.sample)
3.times do |i|
    image_url = 'https://loremflickr.com/300/300/house,room,bathroom'
    file = URI.open(image_url)
    flat.photos.attach(io: file, filename: "image#{i}.jpg", content_type: 'image/jpg')
    puts "image#{i}.jpg uploaded!!!"
end

puts "criando!"
