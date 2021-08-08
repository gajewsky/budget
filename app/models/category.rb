# Model representing single income/expense Category
class Category < ApplicationRecord
  enum kind: { expense: 0, income: 1 }
  validates :title, presence: true, uniqueness: true
  has_many :subcategories
  accepts_nested_attributes_for :subcategories,
    reject_if: :all_blank,
    allow_destroy: true
end
