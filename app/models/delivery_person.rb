class DeliveryPerson < ActiveRecord::Base
	has_many :form_values
	belongs_to :user
	delegate :email, :to=> :user, :prefix=>true, :allow_nil=>true

end
