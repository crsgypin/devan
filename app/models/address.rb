class Address < ActiveRecord::Base
	belongs_to :city
	belongs_to :district
	belongs_to :address_link, :polymorphic => true
end
