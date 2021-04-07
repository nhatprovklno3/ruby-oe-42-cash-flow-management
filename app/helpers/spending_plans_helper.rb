module SpendingPlansHelper
  def select_for_type_plan
    I18n.t("spending_plans.form.option_for_type_plan")
  end

  def select_for_type_repeat
    I18n.t("spending_plans.form.option_for_type_repeat")
  end

  def select_budget
    I18n.t("spending_plans.form.option_new_budget")
        .merge @current_user.budgets.pluck(:name, :id).to_h
  end

  def select_budget_when_search
    @current_user.budgets.pluck(:name, :id).to_h
  end
end
