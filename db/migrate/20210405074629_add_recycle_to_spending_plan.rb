class AddRecycleToSpendingPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :spending_plans, :recycle, :boolean, default: false
  end
end
