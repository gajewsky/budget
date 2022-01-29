# frozen_string_literal: true

class Income < ApplicationRecord
  include Rangable
  before_validation :set_operation_date
  paginates_per 30
  belongs_to :subcategory
  belongs_to :user
  validates :value, presence: true
  validates :operation_date, presence: true

  def self.group_by_subcategory(incomes = Income.all)
    incomes.group_by(&:subcategory).map do |subcategory, subincomes|
      [subcategory&.title, subincomes.map(&:value).reduce(:+)]
    end
  end
end
