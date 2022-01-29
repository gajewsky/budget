# frozen_string_literal: true

# Bills Controller
class BillsController < ApplicationController
  def index
    total_value = bills.map(&:value).reduce(:+)

    render locals: { bills: bills.page(params[:page]), total_value: }
  end

  def new
    bill = Bill.new.tap { |b| b.expenses.build }

    render locals: { bill: }
  end

  def create
    bill = Bill.new bill_params

    if bill.save
      redirect_to new_bill_url, notice: 'Bill was successfully created.'
    else
      render :new, locals: { bill: }
    end
  end

  def edit
    render locals: { bill: }
  end

  def update
    if bill.update bill_params
      redirect_to bills_url, notice: 'Bill was successfully updated.'
    else
      render :edit, locals: { bill: }
    end
  end

  def destroy
    bill.destroy!

    redirect_to bills_url, notice: 'Bill was successfully destroyed.'
  end

  private

  def bills
    @bills ||= begin
      bills = bills_with_relations.where user_id: user_ids
      bills = bills.tagged_with params[:tag] if params[:tag]
      bills = bills.dividable if params[:dividable]
      bills.reorder 'operation_date DESC'
    end
  end

  def bills_with_relations
    bills = Bill.includes({ expenses: [{ subcategory: :category }, :taggings] }, :user, :contractor)
    params[:q] ? bills.search_by_description(params[:q]) : bills
  end

  def bill
    @bill ||= Bill.find params[:id]
  end

  def bill_params
    params.require(:bill).permit \
      :operation_date,
      :subcategory_id,
      :contractor_id,
      :user_id,
      :to_divide,
      :photo,
      expenses_attributes: %i[
        id description value to_divide track subcategory_id _destroy tag_list
      ]
  end
end
