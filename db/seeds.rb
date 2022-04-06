# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

Like.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all

(1..20).each do |id|
  User.create!(
      id: id, 
      name: Faker::Name.name,
      photo: Faker::Lorem.sentence,
      bio: Faker::Lorem.paragraph(sentence_count: 8, supplemental: true),
      postsCounter: 0,
      email: Faker::Internet.email,
      password: "123456"
  )
end

(1..50).each do |id|
  Post.create!(
      id: id,
      author_id: rand(1..20),
      title: Faker::Book.title,
      text: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true),
      commentsCounter: 0,
      likesCounter: 0,
  )
end

(1..50).each do |id|
  Comment.create!(
      id: id,
      post_id: rand(1..50),
      author_id: rand(1..20),
      text: Faker::Lorem.paragraph,
  )
end

(1..50).each do |id|
  Like.create!(
      id: id,
      author_id: rand(1..20),
      post_id: rand(1..50),
  )
end

User.all.each do |u|
  u.postsCounter = u.posts.count
  u.save
end

Post.all.each do |p|
  p.commentsCounter = p.comments.count
  p.likesCounter = p.likes.count
  p.save
end

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end