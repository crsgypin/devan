module DailyFormsHelper

	def daily_form_title(daily_form)
		if daily_form.date == Date.today
			return "今日表單"
		else
			return "#{daily_form.date.strftime('%m月%d日')}表單"
		end
	end

end
