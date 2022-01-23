# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.transaction do
  users = User.create!(
    [
      {
        email: 'admin@example.com',
        password: 'password',
        password_confirmation: 'password'
      },
      {
        email: 'second@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    ]
  )

  cat_1 = Category.where(title: 'Food', kind: 0).first_or_create!
  cat_2 = Category.where(title: 'House', kind: 0).first_or_create!
  cat_3 = Category.where(title: 'Transport', kind: 0).first_or_create!
  cat_4 = Category.where(title: 'Telecommunication', kind: 0).first_or_create!
  cat_5 = Category.where(title: 'Healthcare', kind: 0).first_or_create!
  cat_6 = Category.where(title: 'Cloth', kind: 0 ).first_or_create!
  cat_7 = Category.where(title: 'Hygiene', kind: 0).first_or_create!
  cat_8 = Category.where(title: 'Trips', kind: 0).first_or_create!
  cat_9 = Category.where(title: 'Entertainment', kind: 0).first_or_create!
  cat_10 = Category.where(title: 'Other expenses', kind: 0).first_or_create!
  cat_11 = Category.where(title: 'Incomes', kind: 1).first_or_create!

  subcategories = Subcategory.create!(
    [
      { title: 'House', category: cat_1 },
      { title: 'City', category: cat_1 },
      { title: 'Job', category: cat_1 },
      { title: 'Alcohol', category: cat_1 },
      { title: 'Other', category: cat_1 },
      { title: 'Rent', category: cat_2 },
      { title: 'Electricity', category: cat_2 },
      { title: 'Gas', category: cat_2 },
      { title: 'Heating', category: cat_2 },
      { title: 'Means', category: cat_2 },
      { title: 'Equipment', category: cat_2 },
      { title: 'Pet', category: cat_2 },
      { title: 'Fuel', category: cat_3 },
      { title: 'Ticket', category: cat_3 },
      { title: 'Taxi', category: cat_3 },
      { title: 'Public transport', category: cat_3 },
      { title: 'Other', category: cat_2 },
      { title: 'Other', category: cat_3 },
      { title: 'Phone', category: cat_4 },
      { title: 'Music', category: cat_4 },
      { title: 'Internet', category: cat_4 },
      { title: 'Other', category: cat_4 },
      { title: 'Doctor', category: cat_5 },
      { title: 'Research', category: cat_5 },
      { title: 'Medicine', category: cat_5 },
      { title: 'Other', category: cat_5 },
      { title: 'Cloth', category: cat_6 },
      { title: 'Boots', category: cat_6 },
      { title: 'Accessories', category: cat_6 },
      { title: 'Other', category: cat_6 },
      { title: 'Makeup', category: cat_7 },
      { title: 'Services', category: cat_7 },
      { title: 'Hygienic', category: cat_7 },
      { title: 'Other', category: cat_7 },
      { title: 'Transport', category: cat_8 },
      { title: 'Cultural', category: cat_8 },
      { title: 'Equipment', category: cat_8 },
      { title: 'Souvenirs', category: cat_8 },
      { title: 'Food', category: cat_8 },
      { title: 'Other', category: cat_8 },
      { title: 'Sport', category: cat_9 },
      { title: 'Cinema', category: cat_9 },
      { title: 'Concerts', category: cat_9 },
      { title: 'Books', category: cat_9 },
      { title: 'Hobby', category: cat_9 },
      { title: 'Other', category: cat_9 },
      { title: 'Charity', category: cat_10 },
      { title: 'Gifts', category: cat_10 },
      { title: 'RTV Equipment', category: cat_10 },
      { title: 'Education', category: cat_10 },
      { title: 'Other', category: cat_10 },
      { title: 'Salary', category: cat_11 },
      { title: 'Other', category: cat_11 },
      { title: 'Accommodation', category: cat_8 }
    ]
  )

  Contractor.create!( [
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
    ]
  )

  ActsAsTaggableOn::Tag.create(
    [
      { name: Faker::Hipster.word, taggings_count: 1 },
      { name: Faker::Hipster.word, taggings_count: 1 },
      { name: Faker::Hipster.word, taggings_count: 4 },
      { name: Faker::Hipster.word, taggings_count: 3 },
      { name: Faker::Hipster.word, taggings_count: 2 },
      { name: Faker::Hipster.word, taggings_count: 2 },
      { name: Faker::Hipster.word, taggings_count: 3 },
      { name: Faker::Hipster.word, taggings_count: 2 },
      { name: Faker::Hipster.word, taggings_count: 13 },
      { name: Faker::Hipster.word, taggings_count: 4 },
      { name: Faker::Hipster.word, taggings_count: 2 },
      { name: Faker::Hipster.word, taggings_count: 10 }
    ]
  )
  12.times do |n|
    Income.create!(
      [
        {
          value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          operation_date: n.months.ago,
          subcategory: cat_11.subcategories.sample,
          user: users.first
        },
        {
          value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          operation_date: n.months.ago,
          subcategory: cat_11.subcategories.sample,
          user: users.second
        }
      ]
    )
  end

#   500.times do
#     expense = Expense.create!(
#       operation_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
#       value: Faker::Number.decimal(l_digits: 2, r_digits: 2),
#       subcategory: subcategories.sample,
#       user: users.sample,
#       to_divide: [true, false].sample
#     )

#     Bill.create!(
#       operation_date: expense.operation_date,
#       user: users.sample,
#       contractor_id: Contractor.pluck(:id).sample,
#       to_divide: true,
#       expenses: [expense]
#     )
#   end
end
