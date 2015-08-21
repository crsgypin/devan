class Form2Value < ActiveRecord::Base
	belongs_to :daily_form
	belongs_to :customer
	belongs_to :delivery_person
	belongs_to :manufacturer
	has_many :form_value_users, :as=>:form_value_user_link, :dependent=>:destroy
	has_many :users, :through=>:form_value_users

	delegate :name, :to => :customer, :prefix => true, :allow_nil => true
	delegate :name, :to => :delivery_person, :prefix => true, :allow_nil => true

	before_save :set_manufacturer

private
	def set_manufacturer
		self.manufacturer = Manufacturer.find_by_name("豆之味")
	end
end
