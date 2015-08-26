class DeleteDozhuweiFormValue < ActiveRecord::Migration
  def up
  	drop_table :dozhuwei_form_values
  end
end
