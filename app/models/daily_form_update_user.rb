class DailyFormUpdateUser < ActiveRecord::Base
	belongs_to :daily_form
	belongs_to :user
end
