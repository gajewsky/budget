# frozen_string_literal: true

# Categories Controller
class CategoriesController < ApplicationController
  def index
    pagination, categories = pagy(filtered_categories, items: 20)

    render locals: { categories:, pagination: }
  end

  def new
    category = Category.new.tap { |c| c.subcategories.build }

    render locals: { category: }
  end

  def create
    category = Category.new(category_params)

    if category.save
      redirect_to categories_url, notice: 'Category was successfully created.'
    else
      render :new, locals: { category: }
    end
  end

  def edit
    render locals: { category: }
  end

  def update
    if category.update category_params
      redirect_to categories_url, notice: 'Category was successfully updated.'
    else
      render :edit, locals: { category: }
    end
  end

  def destroy
    category.destroy!

    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private

  def filtered_categories
    @filtered_categories ||= Category.includes(:subcategories)
  end

  def category
    @category ||= Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit \
      :title,
      :description,
      :kind,
      subcategories_attributes: %i[id description title _destroy]
  end
end
