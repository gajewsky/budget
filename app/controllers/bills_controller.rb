# Bills Controller
class BillsController < ApplicationController
  before_action :set_bill, only: %i[show edit update destroy]

  def index
    @total_value = bills.map(&:value).reduce(:+)
    @bills = bills.page(params[:page])
  end

  def new
    @bill = Bill.new
    @bill.expenses.build
  end

  def create
    @bill = Bill.new(bill_params)
    @bill.user_id ||= current_user.id

    if @bill.save
      redirect_to new_bill_url, notice: 'Bill was successfully created.'
    else
      render :new
    end
  end

  def update
    if @bill.update(bill_params)
      redirect_back fallback_location: bills_url, notice: 'Bill was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @bill.destroy
    redirect_back fallback_location: bills_url, notice: 'Bill was successfully destroyed.'
  end

  private

  def bills
    @bills ||= begin
      bills = bills_with_relations.where(user_id: user_ids)
      bills = bills.tagged_with(params[:tag]) if params[:tag]
      bills = bills.dividable if params[:dividable]
      bills.reorder('operation_date DESC')
    end
  end

  def bills_with_relations
    bills = Bill.includes(
      { expenses: [{ subcategory: :category }, :taggings] },
      :user,
      :contractor
    )
    params[:q] ? bills.search_by_description(params[:q]) : bills
  end

  def set_bill
    @bill = Bill.find(params[:id])
  end

  def bill_params
    params.require(:bill).permit(
      :operation_date,
      :subcategory_id,
      :contractor_id,
      :user_id,
      :to_divide,
      :photo,
      expenses_attributes: %i[
        id description value to_divide track subcategory_id _destroy tag_list
      ]
    )
  end
end
