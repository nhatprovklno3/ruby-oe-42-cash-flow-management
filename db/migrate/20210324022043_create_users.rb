class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.datetime :reset_sent_at
      t.integer :role, default: 0
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
