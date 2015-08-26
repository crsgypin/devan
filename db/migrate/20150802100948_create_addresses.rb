class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.text :address
    	t.integer :city_id, :index=>true
    	t.integer :district_id, :index=>true
    	t.string :postal_code
    	t.belongs_to :address_link, :polymorphic => true

      t.timestamps null: false
    end
  end
end
