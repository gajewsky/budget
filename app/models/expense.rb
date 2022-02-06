# frozen_string_literal: true

class Expense < ApplicationRecord
  include PgSearch::Model
  include Rangable

  before_validation :set_fields_from_bill
  acts_as_taggable
  belongs_to :bill
  belongs_to :subcategory
  belongs_to :user
  belongs_to :contractor
  validates :value, presence: true

  scope :trackable, -> { where(track: true) }

  pg_search_scope :search_by_description, against: :description

  def self.group_by_category(expenses = Expense.all)
    expenses.group_by(&:subcategory).group_by { |sub| sub.first.category }
  end

  private

  def set_fields_from_bill
    return unless bill

    self.contractor_id = bill.contractor_id
    self.user_id = bill.user_id
    self.operation_date = bill.operation_date
  end
end
