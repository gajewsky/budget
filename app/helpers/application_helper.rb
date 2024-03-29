# frozen_string_literal: true

# Bunch of view helper methods used both in incomes and expenses
module ApplicationHelper
  include Pagy::Frontend

  BUDGET_START_DATE = '2016-09-01'.to_date

  def sum_values(valuable)
    return 0 if valuable.empty?

    valuable.map(&:value).reduce(:+)
  end

  def number_to_pln(number)
    ActionController::Base.helpers.number_to_currency number, unit: 'zł', format: '%n %u'
  end

  def pln_per_month(number)
    return 0 unless number

    today = Date.today
    months_since_start = (BUDGET_START_DATE.year * 12) + BUDGET_START_DATE.month
    result = Float(number) / (((today.year * 12) + today.month) - months_since_start)
    ActionController::Base.helpers.number_to_currency result, unit: 'zł', format: '%n %u'
  end

  def pln_per_day(number)
    return 0 unless number

    result = number / Float((Date.today - BUDGET_START_DATE))

    ActionController::Base.helpers.number_to_currency result, unit: 'zł', format: '%n %u'
  end

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-error'
    when 'alert' then 'alert alert-error'
    end
  end

  def category_label(subcategory)
    "#{subcategory&.category&.title}/#{subcategory&.title}"
  end
end
