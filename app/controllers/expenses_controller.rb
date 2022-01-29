# frozen_string_literal: true

class ExpensesController < ApplicationController
  def index
    total_value = expenses_with_relations.map(&:value).reduce(:+)
    expenses = expenses_with_relations.page params[:page]

    render locals: { total_value:, expenses: }
  end

  def tracking
    trackings = Expense.trackable

    render locals: { trackings: }
  end

  private

  def expenses_with_relations
    expenses = Expense.includes(:taggings, :user, subcategory: :category).reorder 'operation_date DESC'

    params[:q] ? expenses.search_by_description(params[:q]) : expenses
  end
end
