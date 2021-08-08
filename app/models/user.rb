# Model representing single user
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bills
  has_many :expenses, through: :bills
end
