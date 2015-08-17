class Address < ActiveRecord::Base
	geocoded_by :address, :latitude  => :lat, :longitude => :lng
	after_validation :geocode 

	belongs_to :city
	belongs_to :district
	belongs_to :address_link, :polymorphic => true
end
