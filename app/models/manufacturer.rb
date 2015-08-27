class Manufacturer < ActiveRecord::Base
	validates_presence_of :name

	has_many :manufacturer_keys
	accepts_nested_attributes_for :manufacturer_keys, allow_destroy: true	

	has_many :form_values
	accepts_nested_attributes_for :manufacturer_keys

	has_many :addresses, :as => :address_link, :dependent=>:destroy
	accepts_nested_attributes_for :addresses, allow_destroy: true

	has_many :phones, :as => :phone_link, :dependent=>:destroy
	accepts_nested_attributes_for :phones, allow_destroy: true

	has_many :faxes, -> { where :phone_link_type=> "ManufacturerFax"},
										 :foreign_key=>:phone_link_id, 
										 :class_name=>'Phone', 
										 :dependent=>:destroy
	accepts_nested_attributes_for :faxes, allow_destroy: true

	before_destroy :check_form_values

private
	
	def check_form_values
		if self.form_values.count >0 
			return false
		end
	end
end
