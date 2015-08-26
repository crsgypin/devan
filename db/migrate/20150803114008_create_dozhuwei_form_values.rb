class CreateDozhuweiFormValues < ActiveRecord::Migration
  def change
    create_table :dozhuwei_form_values do |t|
      t.integer :form_value_index
      t.integer :daily_form_id, :index=>true
      t.integer :customer_id, :index=>true
      t.integer :delivery_person_id, :index=>true
    	t.integer :cash
    	t.integer :monthly
    	t.integer :special_monthly
    	t.integer :unreceivably
    	t.integer :delivery_fee
    	t.integer :receivable_cash
    	t.string :note

      t.timestamps null: false
    end
  end
end
