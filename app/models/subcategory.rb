# frozen_string_literal: true

# Model representing single income/expense subcategory
class Subcategory < ApplicationRecord
  validates :title, presence: true
  belongs_to :category
  has_many :expenses
  has_many :bills, through: :expenses
  has_many :incomes

  def label
    "#{category&.title} / #{title}"
  end
end
