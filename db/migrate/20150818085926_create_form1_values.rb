class CreateForm1Values < ActiveRecord::Migration
  def change
    create_table :form1_values do |t|
	    t.integer  :daily_form_id
	    t.integer  :customer_id
	    t.integer  :delivery_person_id
	    t.integer  :manufacturer_id
	    t.integer  :basket
	    t.string   :note

      t.timestamps null: false
    end

    add_index :form1_values, :daily_form_id
    add_index :form1_values, :customer_id
    add_index :form1_values, :delivery_person_id
    add_index :form1_values, :manufacturer_id
  end
end
