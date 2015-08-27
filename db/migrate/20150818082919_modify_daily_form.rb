class ModifyDailyForm < ActiveRecord::Migration
  def up
  	remove_column :daily_forms, :manufacturer_id
  end

  def down
  	add_column :daily_forms, :manufacturer_id, :integer
  	add_index :daily_forms, :manufacturer_id
  end
end
