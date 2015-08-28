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

	has_many :form_values
	has_many :daily_forms, :through=>:form_values

	has_many :customer_routes

	has_one :customer_delivery_day
	accepts_nested_attributes_for :customer_delivery_day, allow_destroy: true

	before_destroy :check_form_values

	def recent_form_values(day_count)
		self.form_values.includes(:daily_form,:customer).joins(:daily_form).where("date >= ?",Date.today - day_count.days).order('daily_forms.date desc')
	end

	def self.active
		self.where(:status=>"經營中")
		#to-do merge all about customer atatus
	end

	def self.search(key_word)
		@customer_ids = Customer.select(:id)
		@customer_ids = @customer_ids.joins("LEFT OUTER JOIN addresses ON addresses.address_link_id = customers.id AND addresses.address_link_type = 'Customer'")
		@customer_ids = @customer_ids.joins("LEFT OUTER JOIN phones ON phones.phone_link_id = customers.id AND (phones.phone_link_type = 'Customer' OR phones.phone_link_type = 'CustomerFax')")

		states = []
		states<< "customers.code LIKE '%#{key_word}%'"
		states<< "customers.name LIKE '%#{key_word}%'"
		states<< "addresses.address LIKE '%#{key_word}%'"
		states<< "phones.number LIKE '%#{key_word}%'"
		@customer_ids = @customer_ids.where(states.join(" OR ")).group('customers.name')
		@customers = Customer.where(:id=>@customer_ids.map{|c| c.id})		
	end


private

	def check_form_values
		if self.form_values.count >0
			return false
		end
	end

end
