class BudgetsController < ApplicationController
  before_action :logged_in_user, only: %i(new create)
  before_action :load_budgets, only: %i(new create)
  before_action :find_parent_budget, only: %i(new create),
                if: ->{params[:parent_id]}

  def new
    @budget = Budget.new
  end

  def create
    @budget = current_user.budgets.build budget_params
    if @budget.save
      flash[:success] = t "flash.create_budget_success"
      redirect_to root_path
    else
      params[:parent_id] = params[:budget][:parent_id]
      render :new
    end
  end

  private

  def budget_params
    params.require(:budget).permit :parent_id, :name, :money
  end

  def load_budgets
    @budgets = current_user.budgets
  end

  def find_parent_budget
    @parent_budget = @budgets.find_by id: params[:parent_id]
    return if @parent_budget

    flash[:danger] = t "flash.not_found_budget"
    redirect_to root_path
  end
end
