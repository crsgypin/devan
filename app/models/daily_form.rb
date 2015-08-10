class DailyForm < ActiveRecord::Base
	has_many :form_values, :dependent => :destroy
	accepts_nested_attributes_for :form_values, allow_destroy: true

	belongs_to :manufacturer
	has_many :daily_form_update_users, :dependent => :destroy
	has_many :users, :through=>:daily_form_update_users
	
end
