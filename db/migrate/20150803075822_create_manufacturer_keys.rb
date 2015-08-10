class CreateManufacturerKeys < ActiveRecord::Migration
  def change
    create_table :manufacturer_keys do |t|
    	t.integer :manufacturer_id, :index=>true
    	t.string :name
    	t.string :note
    	t.integer :mapping_key
      t.timestamps null: false
    end
  end
end
