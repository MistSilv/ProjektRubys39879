class CreateProducers < ActiveRecord::Migration[7.2]
  def change
    create_table :producers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :address

      t.timestamps
    end
  end
end
