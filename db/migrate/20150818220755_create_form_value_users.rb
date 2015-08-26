class CreateFormValueUsers < ActiveRecord::Migration
  def change
    create_table :form_value_users do |t|
    	t.belongs_to :form_value_user_link, :polymorphic => true
    	t.integer :user_id, :index=>true
    	t.integer :form_value_index
      t.timestamps null: false
    end
  end
end
