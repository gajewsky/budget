# frozen_string_literal: true

class ContractorsController < ApplicationController
  def index
    pagination, contractors = pagy(filtered_contractors, items: 20)

    render locals: { contractors:, pagination: }
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
    total_value = contractor.expenses.map(&:value).reduce(:+)
    pagination, bills = pagy(contractor_bills, items: 20)

    render locals: { contractor:, total_value:, pagination:, bills: }
  end

  def destroy
    contractor.destroy!

    redirect_to contractors_url, notice: 'Contractor was successfully destroyed.'
  end

  private

  def filtered_contractors
    @filtered_contractors ||= Contractor.order(:name)
  end

  def contractor
    @contractor ||= Contractor.find params[:id]
  end

  def contractor_bills
    contractor.bills.reorder('operation_date DESC')
  end

  def contractor_params
    params.require(:contractor).permit :name, :subcategory_id, :description, :revolut_id, :card_info
  end
end
