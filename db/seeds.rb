# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'faker'

100.times do
  Review.create(item_id:rand(1..100), user_id:rand(1..50), rating:rand(1..5), body:Faker::Lorem.sentence(3))
end
