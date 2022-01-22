class DashboardController < ApplicationController
  def index
    @incomes = Income.spent_between(date_range).where(user_id: user_ids)
    @expenses_by_day = expenses_by_day
    @average_spent_per_day = average_spent_per_day
    @expenses = expenses
    @bills = bills.spent_between(date_range)
  end

  def overall
    @incomes = Income.where(user_id: user_ids)
    @expenses = Expense.where(user_id: user_ids)
    @average_spent_per_day = average_spent_per_day
    @bills = bills
  end

  private

  def bills
    Bill
      .includes({ expenses: [{ subcategory: :category }, :taggings] }, :user, :contractor)
      .where(user_id: user_ids)
  end

  def expenses
    Expense
      .includes(subcategory: :category)
      .spent_between(date_range)
      .where(user_id: user_ids)
  end

  def date_range
    @date_range ||= begin
      from, to = params.dig('para', 'date')&.split('-')

      return Date.today.at_beginning_of_month..Date.today.at_end_of_month if from.nil? && to.nil?

      from.to_date..to.to_date
    end
  end

  def expenses_by_day
    Expense
      .unscoped
      .spent_between(date_range)
      .where(user_id: user_ids)
      .group_by_day(:operation_date)
      .sum(:value)
      .map { |date, value| [date.strftime('%d-%m-%y'), value.to_f] }
      .to_h
  end

  def average_spent_per_day
    spent_per_day = expenses_by_day.values
    spent_per_day.sum.to_f / spent_per_day.size
  end
end
