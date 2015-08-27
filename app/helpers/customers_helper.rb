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
			list << [index.day.ago.strftime('%m/%d %A'), index]
		end
		list
	end

end
