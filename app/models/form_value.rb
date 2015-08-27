class FormValue < ActiveRecord::Base
	belongs_to :daily_form
	belongs_to :customer
	belongs_to :delivery_person
	belongs_to :manufacturer
	has_many :form_value_users
	has_many :users, :through=>:form_value_users

	delegate :name, :to => :customer, :prefix => true, :allow_nil => true
	delegate :name, :to => :delivery_person, :prefix => true, :allow_nil => true
end
