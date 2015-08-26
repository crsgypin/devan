class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
    	t.string :code
    	t.string :name
    	t.string :description
    	t.string :status

      t.timestamps null: false
    end
  end
end
