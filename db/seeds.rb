# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
5.times do
  user = User.create!(
    email:        Faker::Internet.email,
    password:     Faker::Internet.password
  )
end
users = User.all

15.times do
  Topic.create!(
    user:  users.sample,
    title: Faker::Name.title
  )
end
topics = Topic.all


# Create bookmark
20.times do

  Bookmark.create!(
    topic: topics.sample,
    user:  users.sample,
    url:   Faker::Internet.url
  )
end
bookmarks = Bookmark.all

# Create an admin user
admin = User.create!(
email:    'admin@example.com',
password: 'helloworld'
)


puts "Seed finished"
puts "#{User.count} users created."
puts "#{Topic.count} topics created."
puts "#{Bookmark.count} bookmarks created."
