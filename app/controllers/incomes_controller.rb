class IncomesController < ApplicationController
  before_action :set_income, only: %i[show edit update destroy]

  def index
    incomes = Income.includes(:user, subcategory: :category).where(user_id: user_ids)
    @total_value = incomes.map(&:value).reduce(:+)
    @incomes = incomes.reorder('operation_date DESC').page(params[:page])
  end

  def new
    @income = Income.new
  end

  def create
    @income = Income.new(income_params)
    @income.user = current_user
    if @income.save
      redirect_to new_income_url, notice: 'Income was successfully created.'
    else
      render :new
    end
  end

  def update
    if @income.update(income_params)
      redirect_to incomes_url, notice: 'Income was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @income.destroy
    redirect_to incomes_url, notice: 'Income was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_income
    @income = Income.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def income_params
    params
      .require(:income)
      .permit(:value, :operation_date, :description, :subcategory_id, :user_id)
  end
end
