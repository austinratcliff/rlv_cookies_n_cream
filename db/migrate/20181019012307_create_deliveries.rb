class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.integer :order_id
      t.text :address
      t.datetime :deliver_at

      t.timestamps
    end
  end
end
