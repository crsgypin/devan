class CreateCustomerDeliveryDays < ActiveRecord::Migration
  def change
    create_table :customer_delivery_days do |t|
    	t.integer :customer_id, :index=>true
    	t.boolean :monday
    	t.boolean :tuesday
    	t.boolean :wednesday
    	t.boolean :thursday
    	t.boolean :friday
    	t.boolean :saturday
    	t.boolean :sunday
    	t.boolean :unstable_day
      t.timestamps null: false
    end
  end
end
