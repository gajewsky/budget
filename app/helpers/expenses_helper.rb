module ExpensesHelper
  include ActsAsTaggableOn::TagsHelper

  def cost_per_day(price, transaction_date)
    (price / (Date.today - transaction_date.to_date).to_i).round(2)
  end
end
