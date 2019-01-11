class AddAllergiesToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :allergies, :string
  end
end
