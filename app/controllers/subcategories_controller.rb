# Subcategories Controller
class SubcategoriesController < ApplicationController
  def show
    @subcategory =
      Subcategory
      .includes(incomes: :user, expenses: %i[user taggings])
      .find(params[:id])
  end
end
