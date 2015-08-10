class CreateDailyForms < ActiveRecord::Migration
  def change
    create_table :daily_forms do |t|
    	t.integer :manufacturer_id, :index=>true
    	t.date :date

      t.timestamps null: false
    end
  end
end
