# frozen_string_literal: true
# Model representing single income
class Income < ActiveRecord::Base
  include Rangable
  paginates_per 12
  belongs_to :subcategory
  belongs_to :user
  validates :value, presence: true
  validates :subcategory, presence: true

  def self.group_by_subcategory(incomes = Income.all)
    incomes.group_by(&:subcategory).map do |subcategory, subincomes|
      [subcategory&.title, subincomes.map(&:value).reduce(:+)]
    end
  end
end
