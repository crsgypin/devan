class ModifyFormValueUser < ActiveRecord::Migration
  def change
  	remove_column :form_value_users, :form_value_user_link_id
  	remove_column :form_value_users, :form_value_user_link_type
  	remove_column :form_value_users, :form_value_index
  	add_column :form_value_users, :form_value_id, :integer
  	add_index :form_value_users, :form_value_id
  end
end
