# frozen_string_literal: true

# Bills Controller
class BillsController < ApplicationController
  def index
    pagination, bills = pagy(filtered_bills, items: 20)
    total_value = filtered_bills.map(&:value).reduce(:+)
    subcategories = Subcategory.expanse
    contractors = Contractor.order(:name)
    users = User.order(:email)

    render locals: { bills:, pagination:, subcategories:, contractors:, users:, total_value: }
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

  def filtered_bills
    @filtered_bills ||= ::BillsFilter.call(
      search: params[:search],
      subcategory_id: params[:subcategory_id],
      contractor_id: params[:contractor_id],
      user_id: params[:user_id],
    )
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
