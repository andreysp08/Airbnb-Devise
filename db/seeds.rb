require 'faker'
require 'geocoder'
require 'open-uri'


puts "Seed Flat? (type \"yes\" or any thing)"
result = gets.chomp
if result == "yes"
    puts "Creating Flat . . ."
    name_flat = Faker::Book.title

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
    flat = Flat.create!(name: name_flat, address: address, description: description, latitude: latitude, longitude: longitude, pricing: pricing, avaliability: avaliability, user_id: user_id)
    3.times do |i|
        image_url = 'https://loremflickr.com/300/300/house,room,bathroom'
        file = URI.open(image_url)
        flat.photos.attach(io: file, filename: "image#{i}.jpg", content_type: 'image/jpg')
        puts "image#{i}.jpg uploaded!!!"
    end
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "----------------------------"
    puts "Flat's name: #{name_flat}"
    puts "Address: #{address}"
    puts "Description: #{description}"
    puts "[Lat, long]: #{results.first.coordinates}"
    puts "Pricing: #{pricing}"
    puts "Avaliability: #{avaliability}"
    puts "Owner (email): #{User.find(user_id).email}"
    puts "----------------------------"
    puts "\n\n\n\n\n\n"
    puts "Flat Created!"
else
    puts "\nYou choice dont create a new flat by seed!"
end

puts "\n--Input any keyword to continue!"
gets.chomp

puts "Seed User? (type \"yes\" or any thing)"
result = gets.chomp
if result == "yes"
    puts "\nCreating User . . ."
    username = Faker::Internet.username
    email = Faker::Internet.email(name: username)
    password = Faker::Internet.password
    age = rand(18..85)
    
    User.create!(name: username, email: email, age: age, password: password)
    
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "----------------------------"
    puts "Name: #{username}"
    puts "Email: #{email}"
    puts "Password: #{password}"
    puts "Age: #{age}"
    puts "----------------------------"
    puts "\n\n\n\n\n\n"
    
    puts "User Created!"
else
    puts "\nYou choice dont create a new user by seed!"
    puts "\n--Input any keyword to exit!"
    gets.chomp
end




# Flat.reindex?????