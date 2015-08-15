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

	has_one :customer_delivery_day
	accepts_nested_attributes_for :customer_delivery_day, allow_destroy: true

	before_destroy :check_form_values

	def recent_form_values(day_count)
		self.form_values.includes(:daily_form,:customer).joins(:daily_form).where("date >= ?",Date.today - day_count.days).order('daily_forms.date desc')
	end

private

	def check_form_values
		if self.form_values.count >0
			return false
		end
	end

end
