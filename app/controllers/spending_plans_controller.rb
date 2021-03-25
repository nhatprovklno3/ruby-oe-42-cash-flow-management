class SpendingPlansController < ApplicationController
  before_action :logged_in_user
  before_action :load_budget, only: :create

  def new
    @spending_plan = SpendingPlan.new
  end

  def create
    @spending_plan = current_user.spending_plans.build spending_plan_params
    @spending_plan.budget_id = @budget.id
    if @spending_plan.save
      flash[:success] = t("flash.create_plan_success")
      redirect_to new_spending_plan_path
    else
      render :new
    end
  end

  private

  def spending_plan_params
    params.require(:spending_plan).permit :name, :start_date,
                                          :end_date, :total_money, :note,
                                          :plan_type, :is_repeat,
                                          :repeat_type, :budget_id
  end

  def load_budget
    @budget = Budget.find_by id: params[:spending_plan][:budget_id] if
    params[:spending_plan].present?
    return if @budget.present?

    flash[:warning] = t "flash.budget_can_not_load"
    redirect_to new_spending_plan_path
  end
end
