class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
    	t.string :number
    	t.belongs_to :phone_link, :polymorphic => true

      t.timestamps null: false
    end
  end
end
