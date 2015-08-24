module CustomersHelper

	def setup_customer_status(customer)
		if !customer.status.present?
			customer.status = "經營中"
			customer.save!
		end
		customer
	end
end
