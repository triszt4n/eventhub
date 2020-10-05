# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_count = 16
event_per_user = 3
post_per_event = 5

user_count.times do |u|
  user = User.create!(
    email: Faker::Internet.email, 
    password: Faker::Internet.password, 
    name: Faker::Name.name, 
    city: Faker::Address.city, 
    profile: Faker::Music.album, 
    about: Faker::Lorem.paragraph, 
    public: Faker::Boolean.boolean
  )
  puts "User created: #{u + 1}"
  event_per_user.times do |e|
    event = Event.create!(
      title: Faker::Book.title, 
      theme: Faker::Book.genre, 
      short_desc: Faker::Lorem.paragraph,
      full_desc: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
      published: Faker::Boolean.boolean, 
      start_date: DateTime.new(2020,11,u+1,e+1,0,0), 
      end_date: DateTime.new(2020,11,u+4,e+2,0,0), 
      place: Faker::Address.community, 
      user: user
    )
    puts "  Event created: #{u * event_per_user + e + 1}"
    post_per_event.times do |p|
      puts "    Post created: #{(u * event_per_user + e) * post_per_event + p + 1}"
      Post.create!(
        title: Faker::Lorem.question, 
        body: Faker::Lorem.paragraph, 
        event_id: event.id
      )
    end
  end
end
