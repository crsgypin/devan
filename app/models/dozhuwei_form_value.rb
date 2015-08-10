class DozhuweiFormValue < ActiveRecord::Base
	belongs_to :daily_form
	belongs_to :customer
	belongs_to :delivery_person

	delegate :name, :to => :customer, :prefix => true, :allow_nil => true
	delegate :name, :to => :delivery_person, :prefix => true, :allow_nil => true

end
