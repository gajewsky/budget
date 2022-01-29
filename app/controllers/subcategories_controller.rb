# frozen_string_literal: true

class SubcategoriesController < ApplicationController
  def show
    subcategory = Subcategory.includes(incomes: :user, expenses: %i[user taggings]).find params[:id]
    
    render locals: { subcategory: }
  end
end
