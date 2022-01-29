# frozen_string_literal: true

class ExpensesController < ApplicationController
  def index
    pagination, expenses = pagy(filtered_expenses, items: 20)
    total_value = filtered_expenses.map(&:value).reduce(:+)

    render locals: { total_value:, expenses:, pagination: }
  end

  def tracking
    trackings = Expense.trackable

    render locals: { trackings: }
  end

  private

  def filtered_expenses
    @filtered_expenses ||= begin
      expenses = Expense.includes(:taggings, :user, subcategory: :category).reorder 'operation_date DESC'

      params[:q] ? expenses.search_by_description(params[:q]) : expenses
    end
  end
end
