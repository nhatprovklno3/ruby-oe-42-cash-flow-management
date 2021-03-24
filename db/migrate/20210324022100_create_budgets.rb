class CreateBudgets < ActiveRecord::Migration[6.1]
  def change
    create_table :budgets do |t|
      t.string :name
      t.integer :parent_id
      t.float :money
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
