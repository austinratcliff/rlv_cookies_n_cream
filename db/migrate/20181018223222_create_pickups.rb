class CreatePickups < ActiveRecord::Migration[5.1]
  def change
    create_table :pickups do |t|
      t.integer :order_id
      t.datetime :pickup_at

      t.timestamps
    end
  end
end
