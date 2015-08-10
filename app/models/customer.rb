class Customer < ActiveRecord::Base
	has_many :addresses, :as => :address_link, :dependent=>:destroy
	accepts_nested_attributes_for :addresses, allow_destroy: true

	has_many :phones, :as => :phone_link, :dependent=>:destroy
	accepts_nested_attributes_for :phones, allow_destroy: true

	has_many :faxes, -> { where :phone_link_type=> "CustomerFax"},
										 :foreign_key=>:phone_link_id, 
										 :class_name=>'Phone', 
										 :dependent=>:destroy
	accepts_nested_attributes_for :faxes, allow_destroy: true

end
