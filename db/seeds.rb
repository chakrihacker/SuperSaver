# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

##############################################################################

Rails.logger.info '1. Creating users'

User.destroy_all

10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    confirmed_at: Time.current,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )
end

##############################################################################

Rails.logger.info '2. Creating Categories'

Category.destroy_all

categories = Category.create([
                               { name: 'Travel' },
                               { name: 'Shopping' },
                               { name: 'Bills' },
                               { name: 'Food' },
                               { name: 'Events' },
                               { name: 'Others' }
                             ])
Category.create([
                  { name: 'Bus', parent_id: categories.first.id },
                  { name: 'Flights', parent_id: categories.first.id },
                  { name: 'Cab', parent_id: categories.first.id },
                  { name: 'Hotels', parent_id: categories.first.id }
                ])
Category.create([
                  { name: 'Health', parent_id: categories.second.id },
                  { name: 'Fashion', parent_id: categories.second.id },
                  { name: 'Furniture', parent_id: categories.second.id },
                  { name: 'Appliances', parent_id: categories.second.id },
                  { name: 'EyeCare', parent_id: categories.second.id }
                ])
Category.create([
                  { name: 'PostPaid', parent_id: categories.third.id },
                  { name: 'Prepaid', parent_id: categories.third.id },
                  { name: 'DTH', parent_id: categories.third.id },
                  { name: 'LandLine', parent_id: categories.third.id },
                  { name: 'Electricity', parent_id: categories.third.id },
                  { name: 'Broadband', parent_id: categories.third.id }
                ])
Category.create([
                  { name: 'Delivery', parent_id: categories.fourth.id },
                  { name: 'Restaurants', parent_id: categories.fourth.id }
                ])
Category.create([{ name: 'Movies', parent_id: categories.fifth.id },
                 { name: 'Games', parent_id: categories.fifth.id },
                 { name: 'Events', parent_id: categories.fifth.id }])