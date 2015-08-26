class RemoveFormValue1 < ActiveRecord::Migration
  def up
  	drop_table :form1_values

  end

  def down
	  create_table :form1_values do |t|
	    t.integer  :daily_form_id, :index=>true
	    t.integer  :customer_id, :index=>true
	    t.integer  :delivery_person_id, :index=>true
	    t.integer  :manufacturer_id
	    t.integer  :basket
	    t.string   :note
    end
  end
end
