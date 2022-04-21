# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.transaction do
  users = User.create! \
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

  cat1 = Category.where(title: 'Food', kind: 0).first_or_create!
  cat2 = Category.where(title: 'House', kind: 0).first_or_create!
  cat3 = Category.where(title: 'Transport', kind: 0).first_or_create!
  cat4 = Category.where(title: 'Telecommunication', kind: 0).first_or_create!
  cat5 = Category.where(title: 'Healthcare', kind: 0).first_or_create!
  cat6 = Category.where(title: 'Cloth', kind: 0).first_or_create!
  cat7 = Category.where(title: 'Hygiene', kind: 0).first_or_create!
  cat8 = Category.where(title: 'Trips', kind: 0).first_or_create!
  cat9 = Category.where(title: 'Entertainment', kind: 0).first_or_create!
  cat10 = Category.where(title: 'Other expenses', kind: 0).first_or_create!
  cat11 = Category.where(title: 'Incomes', kind: 1).first_or_create!

  subcategories = Subcategory.create! \
    [
      { title: 'House', category: cat1 },
      { title: 'City', category: cat1 },
      { title: 'Job', category: cat1 },
      { title: 'Alcohol', category: cat1 },
      { title: 'Other', category: cat1 },
      { title: 'Rent', category: cat2 },
      { title: 'Electricity', category: cat2 },
      { title: 'Gas', category: cat2 },
      { title: 'Heating', category: cat2 },
      { title: 'Means', category: cat2 },
      { title: 'Equipment', category: cat2 },
      { title: 'Pet', category: cat2 },
      { title: 'Fuel', category: cat3 },
      { title: 'Ticket', category: cat3 },
      { title: 'Taxi', category: cat3 },
      { title: 'Public transport', category: cat3 },
      { title: 'Other', category: cat2 },
      { title: 'Other', category: cat3 },
      { title: 'Phone', category: cat4 },
      { title: 'Music', category: cat4 },
      { title: 'Internet', category: cat4 },
      { title: 'Other', category: cat4 },
      { title: 'Doctor', category: cat5 },
      { title: 'Research', category: cat5 },
      { title: 'Medicine', category: cat5 },
      { title: 'Other', category: cat5 },
      { title: 'Cloth', category: cat6 },
      { title: 'Boots', category: cat6 },
      { title: 'Accessories', category: cat6 },
      { title: 'Other', category: cat6 },
      { title: 'Makeup', category: cat7 },
      { title: 'Services', category: cat7 },
      { title: 'Hygienic', category: cat7 },
      { title: 'Other', category: cat7 },
      { title: 'Transport', category: cat8 },
      { title: 'Cultural', category: cat8 },
      { title: 'Equipment', category: cat8 },
      { title: 'Souvenirs', category: cat8 },
      { title: 'Food', category: cat8 },
      { title: 'Other', category: cat8 },
      { title: 'Sport', category: cat9 },
      { title: 'Cinema', category: cat9 },
      { title: 'Concerts', category: cat9 },
      { title: 'Books', category: cat9 },
      { title: 'Hobby', category: cat9 },
      { title: 'Other', category: cat9 },
      { title: 'Charity', category: cat10 },
      { title: 'Gifts', category: cat10 },
      { title: 'RTV Equipment', category: cat10 },
      { title: 'Education', category: cat10 },
      { title: 'Other', category: cat10 },
      { title: 'Salary', category: cat11 },
      { title: 'Other', category: cat11 },
      { title: 'Accommodation', category: cat8 }
    ]

  Contractor.create! \
    [
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id },
      { name: Faker::Hipster.word, subcategory_id: subcategories.sample.id }
    ]

  ActsAsTaggableOn::Tag.create \
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

  12.times do |n|
    Income.create! \
      [
        {
          value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          operation_date: n.months.ago,
          subcategory: cat11.subcategories.sample,
          user: users.first
        },
        {
          value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          operation_date: n.months.ago,
          subcategory: cat11.subcategories.sample,
          user: users.second
        }
      ]
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

  Rails.logger.debug 'Yay, db seeded! admin@example.com:password'
end
