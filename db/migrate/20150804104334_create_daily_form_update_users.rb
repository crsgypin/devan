class CreateDailyFormUpdateUsers < ActiveRecord::Migration
  def change
    create_table :daily_form_update_users do |t|
    	t.integer :user_id, :index=>true
    	t.integer :daily_form_id, :index=>true
      t.timestamps null: false
    end
  end
end
