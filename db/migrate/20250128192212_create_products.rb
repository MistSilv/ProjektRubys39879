class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.references :producer, null: false, foreign_key: true
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end
