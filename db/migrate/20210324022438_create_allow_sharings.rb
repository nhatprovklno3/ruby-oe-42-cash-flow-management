class CreateAllowSharings < ActiveRecord::Migration[6.1]
  def change
    create_table :allow_sharings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :spending_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
