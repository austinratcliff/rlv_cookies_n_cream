class AddCancelUrlToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :cancel_url, :string
  end
end
