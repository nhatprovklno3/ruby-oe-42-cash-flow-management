module StatisticsHelper
  def income_expense_by_name_plan
    bar_chart @spending_plans.group(:plan_type, :name).sum(:total_money)
  end

  def condition_display_defaul_title?
    params[:start_date].blank? || params[:end_date].blank? ||
      params[:end_date].to_date < params[:start_date].to_date
  end
end
