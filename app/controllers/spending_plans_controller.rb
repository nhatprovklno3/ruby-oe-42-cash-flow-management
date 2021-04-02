class SpendingPlansController < ApplicationController
  before_action :logged_in_user
  before_action :load_spending_plan, only: :show
  before_action :load_budget, only: :create

  def new
    @spending_plan = SpendingPlan.new
  end

  def index
    @spending_plans = current_user.spending_plans.includes(:budget)
    search_spending_plan
    @spending_plans = @spending_plans.order_by_creat_at_desc
                                     .paginate page: params[:page],
                                      per_page: Settings.paginate.per_page
  end

  def show; end

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

  def load_spending_plan
    @spending_plan = SpendingPlan.find_by id: params[:id]
    return if @spending_plan.present? &&
              @spending_plan.user.id == current_user.id

    check_spending_plan
  end

  def check_spending_plan
    if @spending_plan.blank?
      flash[:warning] = t "flash.plan_not_present"
    elsif @spending_plan.user.id != current_user.id
      flash[:warning] = t "flash.not_your_plan"
    end
    redirect_to spending_plans_path
  end

  def search_spending_plan
    @spending_plans = @spending_plans.filter_name params[:keyword] if
                      params[:keyword].present?
    @spending_plans = @spending_plans.filter_budget_id params[:budget_id] if
                      params[:budget_id].present?
    @spending_plans = @spending_plans.filter_plan_type params[:plan_type] if
                      params[:plan_type].present?
  end
end
