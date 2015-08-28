class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
    	t.integer :user_id, :index=>true
    	t.boolean :edit_form
    	t.boolean :edit_setting
    	t.boolean :edit_permission
      t.timestamps null: false
    end
  end
end
