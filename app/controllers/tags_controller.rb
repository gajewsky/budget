class TagsController < ApplicationController
  def index
    @total_value = expenses.map(&:value).reduce(:+)
    @paginated_expenses = expenses.page(params[:page])
  end

  private

  def expenses
    @expenses ||= begin
      expenses = expenses_with_relations.where(user_id: user_ids)
      expenses = expenses.tagged_with(params[:tag]) if params[:tag]
      expenses = expenses.where(to_divide: true) if params[:dividable]
      expenses.reorder('operation_date DESC')
    end
  end

  def expenses_with_relations
    Expense.includes(:taggings, :user, subcategory: :category)
  end
end
