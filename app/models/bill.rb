# frozen_string_literal: true

class Bill < ApplicationRecord
  include Rangable
  include PgSearch::Model

  belongs_to :user
  belongs_to :contractor, optional: true
  has_many :expenses, dependent: :destroy

  validates :operation_date, presence: true
  validates :expenses, length: { minimum: 1 }

  scope :dividable, -> { where(to_divide: true) }

  accepts_nested_attributes_for :expenses, reject_if: :all_blank, allow_destroy: true

  pg_search_scope :search_by_expense, using: { tsearch: { prefix: true } }, associated_against: { expenses: :description }

  def value
    expenses.flat_map(&:value).reduce(:+)
  end

  def tag_list
    expenses.flat_map(&:tag_list)
  end
end
