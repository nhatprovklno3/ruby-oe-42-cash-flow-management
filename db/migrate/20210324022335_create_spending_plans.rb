class CreateSpendingPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :spending_plans do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.float :total_money
      t.text :note
      t.integer :plan_type
      t.integer :status, default: 0
      t.boolean :is_repeat, default: false
      t.integer :repeat_type
      t.references :user, null: false, foreign_key: true
      t.references :budget, null: false, foreign_key: true

      t.timestamps
    end
  end
end
