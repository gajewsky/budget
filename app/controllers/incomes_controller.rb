# frozen_string_literal: true

class IncomesController < ApplicationController
  def index
    incomes = Income.includes(:user, subcategory: :category)
      .where(user_id: user_ids)
      .reorder('operation_date DESC')
      .page(params[:page])

    total_value = incomes.map(&:value).reduce(:+)

    render locals: { incomes:, total_value: }
  end

  def new
    income = Income.new

    render locals: { income: }
  end

  def create
    income = Income.new income_params

    if income.save
      redirect_to new_income_url, notice: 'Income was successfully created.'
    else
      render :new, locals: { income: }
    end
  end

  def edit
    render locals: { income: }
  end

  def update
    if income.update income_params
      redirect_to incomes_url, notice: 'Income was successfully updated.'
    else
      render :edit, locals: { income: }
    end
  end

  def destroy
    income.destroy!

    redirect_to incomes_url, notice: 'Income was successfully destroyed.'
  end

  private

  def income
    @income ||= Income.find params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def income_params
    params.require(:income).permit :value, :operation_date, :description, :subcategory_id, :user_id
  end
end
