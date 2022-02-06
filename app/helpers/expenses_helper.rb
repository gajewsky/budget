# frozen_string_literal: true

module ExpensesHelper
  include ActsAsTaggableOn::TagsHelper

  def cost_per_day(price, transaction_date)
    (price / Integer((Date.today - transaction_date.to_date), 10)).round 2
  end
end
