class CreateCustomerRoutes < ActiveRecord::Migration
  def change
    create_table :customer_routes do |t|
    	t.integer :delivery_person_id, :index=>true
    	t.string :wday
    	t.integer :customer_id, :index=>true
      t.timestamps null: false
    end
  end
end
