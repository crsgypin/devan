class DailyForm < ActiveRecord::Base
	default_scope {order(:date=>:desc)}
	has_many :form1_values
	has_many :form2_values
	accepts_nested_attributes_for :form1_values, allow_destroy: true
	accepts_nested_attributes_for :form2_values, allow_destroy: true


	belongs_to :manufacturer

	def self.limitDays(limit_days)
		if limit_days == nil
			limit_days = 10
		elsif limit_days == 'all'
			limit_days = 0
		else
			limit_days = limit_days.to_i
		end

		self.where('date > ?', Time.now-limit_days.days)
	end



end
