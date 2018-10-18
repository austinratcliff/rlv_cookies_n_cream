class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :count
      t.text :description
      t.boolean :is_delivery, default: false

      t.timestamps
    end
  end
end
