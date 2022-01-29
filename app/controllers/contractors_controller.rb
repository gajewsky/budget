# frozen_string_literal: true

class ContractorsController < ApplicationController
  def index
    contractors = Contractor.order :name

    render locals: { contractors: }
  end

  def new
    contractor = Contractor.new

    render locals: { contractor: }
  end

  def create
    contractor = Contractor.new contractor_params

    if contractor.save
      redirect_to contractors_url, notice: 'Contractor was successfully created.'
    else
      render :new, locals: { contractor: }
    end
  end

  def edit
    render locals: { contractor: }
  end

  def update
    if contractor.update contractor_params
      redirect_to contractors_url, notice: 'Contractor was successfully updated.'
    else
      render :edit, locals: { contractor: }
    end
  end

  def show
    total_value = expenses.map(&:value).reduce(:+)
    paginated_bills = contractor.bills.reorder('operation_date DESC').page params[:page]

    render locals: { contractor:, total_value:, paginated_bills: }
  end

  def destroy
    contractor.destroy!

    redirect_to contractors_url, notice: 'Contractor was successfully destroyed.'
  end

  private

  def contractor
    @contractor ||= Contractor.find params[:id]
  end

  def contractor_params
    params.require(:contractor).permit :name, :subcategory_id, :description, :revolut_id, :card_info
  end

  def expenses
    @expenses ||= @contractor.expenses.reorder 'operation_date DESC'
  end
end
