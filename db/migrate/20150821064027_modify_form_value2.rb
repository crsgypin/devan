class ModifyFormValue2 < ActiveRecord::Migration
  def up
  	rename_table :form2_values, :form_values
  	add_column :form_values, :basket, :integer

  end

  def down
		rename_table :form_values, :form2_values
		remove_column :form2_values, :basket
  end
end
