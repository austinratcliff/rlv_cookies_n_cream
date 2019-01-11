class AddColorsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :colors, :string, array: true, default: []
  end
end
