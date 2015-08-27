class AddRowOrderToCustomerRoute < ActiveRecord::Migration
  def change
  	add_column :customer_routes, :row_order, :integer
  end
end
