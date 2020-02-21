# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

##############################################################################

Rails.logger.info '0. Destroy data from DB'

User.destroy_all
Deal.destroy_all
Category.destroy_all
Conversation.destroy_all
ConversationMembership.destroy_all
Message.destroy_all

##############################################################################

Rails.logger.info '1. Creating users'

User.create!(
  name: 'Subramanya',
  email: 'subramanya@fyndx.io',
  password: 'password',
  confirmed_at: Time.current
)

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

##############################################################################

Rails.logger.info '3. Creating Deals'

deal_types = %w[Coupon Membership GiveAway]

100.times do
  is_local_deal = Faker::Boolean.boolean
  Deal.create!(
    deal_type: deal_types.sample,
    name: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4),
    description: Faker::Lorem.paragraph(sentence_count: 5),
    vendor: Faker::Company.name,
    is_local_deal: is_local_deal,
    latitude: is_local_deal ? Faker::Address.latitude : nil,
    longitude: is_local_deal ? Faker::Address.longitude : nil,
    status: true,
    end_date: Faker::Date.forward(days: 365),
    min_price: Faker::Number.between(from: 100, to: 10_000),
    cashback: Faker::Number.between(from: 50, to: 4000).to_s,
    user_id: User.order(Arel.sql('RANDOM()')).first.id,
    category_id: Category.order(Arel.sql('RANDOM()')).first.id
  )
end

##############################################################################

Rails.logger.info '4. Creating Conversations'

25.times do
  deal = Deal.order(Arel.sql('RANDOM()')).first.id
  users = User.order(Arel.sql('RANDOM()'))
  first_user = users.first.id
  second_user = users.second.id
  conversation = Conversation.create!(
    conversation_name: Faker::DcComics.title,
    conversation_type: 'direct',
    slug: deal.to_s + '/' + first_user.to_s,
    status: 'active'
  )
  ConversationMembership.create!(
    conversation_id: conversation.id,
    user_id: first_user
  )
  ConversationMembership.create!(
    conversation_id: conversation.id,
    user_id: second_user
  )

  25.times do
    Message.create!(
      content: Faker::Lorem.sentence,
      conversation_id: conversation.id,
      user_id: [first_user, second_user].sample
    )
  end
end
