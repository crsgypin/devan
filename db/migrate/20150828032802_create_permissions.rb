class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
    	t.integer :user_id, :index=>true
    	t.boolean :member
    	t.boolean :editor
    	t.boolean :admin
      t.timestamps null: false
    end
  end
end
