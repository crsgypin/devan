module CustomersHelper

	def setup_customer_status(customer)
		if !customer.status.present?
			customer.status = "經營中"
			customer.save!
		end
		customer
	end

	def date_list
		list = []
		5.times do |index|
			date = index.day.ago
			name = date.strftime('%m月%d日') + "  " + t("week_day.#{date.strftime('%A')}")
			list << [name, index]
		end
		list
	end

end
