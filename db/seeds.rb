require 'faker'
require 'geocoder'
require 'open-uri'
puts "Seed Users? (type \"yes\" or any thing)"
result = gets.chomp
if result == "yes"
    puts "\nCreating Users . . ."
    User.destroy_all
    20.times do |i|
        username = Faker::Internet.username
        email = Faker::Internet.email(name: username)
        password = Faker::Internet.password
        age = rand(18..85)

        User.create!(name: username, email: email, age: age, password: password)
        puts "Users Created!"
    end
else
    puts "\nYou choice dont create a new user by seed!"
end

puts "\n--Input any keyword to continue!"
gets.chomp


puts "Seed Flats? (type \"yes\" or any thing)"
result = gets.chomp
if result == "yes"
    puts "Creating Flats . . ."
    Flat.destroy_all
    40.times do |i|
        name_flat = Faker::Book.title

        address = Faker::Address.community
        results = Geocoder.search(address)

        description = Faker::Lorem.paragraph(sentence_count: 10)

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
    end
else
    puts "\nYou choice dont create a new user by seed!"
end

puts "\nDONE!\nSeed finished!"




# Flat.reindex?????