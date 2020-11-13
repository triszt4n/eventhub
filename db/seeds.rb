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
follows_per_user = 3
follows_per_event = 3

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

Event.includes(:user).where(published: true).all.each do |event|
  available = [*1..user_count] - [event.user.id]
  follows_per_event.times do |f|
    user_id = available.sample
    EventFollow.create!(
      event: event,
      user: User.find(user_id)
    )
    puts "EventFollow created: event: #{event.id} - follower: #{user_id}"
  end
end

User.where(public: true).all.each do |user|
  available = [*1..user_count] - [user.id]
  follows_per_event.times do |f|
    user_id = available.sample
    UserFollow.create!(
      follower: User.find(user_id),
      followee: user
    )
    puts "UserFollow created: followee: #{user.id} - follower: #{user_id}"
  end
end
