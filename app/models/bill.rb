class Bill < ApplicationRecord
  include Rangable
  paginates_per 50
  has_one_attached :photo

  belongs_to :user
  belongs_to :contractor
  has_many :expenses, dependent: :destroy

  before_validation :set_operation_date

  validates :operation_date, presence: true
  validates :expenses, length: { minimum: 1 }

  scope :dividable, -> { where(to_divide: true) }

  accepts_nested_attributes_for :expenses, reject_if: :all_blank, allow_destroy: true

  def value
    expenses.flat_map(&:value).reduce(:+)
  end

  def tag_list
    expenses.flat_map(&:tag_list)
  end
end
