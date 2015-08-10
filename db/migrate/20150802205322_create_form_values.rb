class CreateFormValues < ActiveRecord::Migration
  def change
    create_table :form_values do |t|
      t.integer :form_value_index
      t.integer :daily_form_id, :index=>true
      t.integer :customer_id, :index=>true
      t.integer :delivery_person_id, :index=>true
    	t.integer :key1
    	t.integer :key2
    	t.integer :key3
    	t.integer :key4
    	t.integer :key5
    	t.integer :key6
    	t.integer :key7
    	t.integer :key8
    	t.string :note

      t.timestamps null: false
    end
  end
end
