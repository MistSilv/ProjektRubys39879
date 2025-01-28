class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :client, null: false, foreign_key: true
      t.decimal :total
      t.string :status
      t.datetime :placed_at

      t.timestamps
    end
  end
end
