class ModifyFormValues < ActiveRecord::Migration
  def up
  	rename_table :form_values, :form2_values
  	remove_column :form2_values, :key7
  	remove_column :form2_values, :key8
  	add_column :form2_values, :manufacturer_id, :integer
  	add_index :form2_values, :manufacturer_id
  end

  def down
  	rename_table :form2_values, :form_values
  	add_column :form_values, :key7, :integer
  	add_column :form_values, :key8, :integer
  	remove_column :form_values, :manufacturer_id
  end
end
