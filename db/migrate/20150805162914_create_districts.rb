class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
    	t.string :name
    	t.string :postal_code
    	t.integer :order
    	t.integer :city_id, :index=>true
      t.timestamps null: false
    end
  end
end
