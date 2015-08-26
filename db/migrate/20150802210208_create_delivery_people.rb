class CreateDeliveryPeople < ActiveRecord::Migration
  def change
    create_table :delivery_people do |t|
    	t.string :code
    	t.string :name
    	t.integer :user_id
    	t.string :status
      t.timestamps null: false
    end
  end
end
