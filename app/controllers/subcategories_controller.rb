# frozen_string_literal: true

class SubcategoriesController < ApplicationController
  def show
    pagination, bills = pagy(subcategory_bills, items: 20)

    render locals: { subcategory:, pagination:, bills: }
  end

  def subcategory_bills
    subcategory.bills.reorder('operation_date DESC')
  end

  def subcategory
    @subcategory ||= Subcategory.find params[:id]
  end
end
