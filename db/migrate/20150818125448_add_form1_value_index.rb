class AddForm1ValueIndex < ActiveRecord::Migration
  def change
  	add_column :form1_values, :form_value_index, :integer
  end
end
