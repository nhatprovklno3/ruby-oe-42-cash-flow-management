module UsersHelper
  def plans_by_month date
    @plans_by_month = current_user.spending_plans.search_by_month_year(date)
  end

  def total_income_by_month
    @total_income_by_month = @plans_by_month.income.sum(:total_money)
  end

  def total_expense_by_month
    @total_expense_by_month = @plans_by_month.expense.sum(:total_money)
  end

  def difference_money
    @total_income_by_month - @total_expense_by_month
  end
end
