class Contractor < ApplicationRecord
  has_many :bills
  has_many :expenses
  belongs_to :subcategory

  validates :name, presence: true
end
