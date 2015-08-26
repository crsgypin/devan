class CustomerRoute < ActiveRecord::Base
	validates_inclusion_of :wday, :in=> %w(monday tuesday wednesday thursday friday saturday sunday)
	belongs_to :customer
	belongs_to :delivery_person

	def self.move_order(move_customer_route, to_index)
		customer_routes = CustomerRoute.where(:delivery_person_id => move_customer_route.delivery_person_id, 
																					:wday=>move_customer_route.wday).order(:row_order)

		move_customer_route.row_order = to_index
		move_customer_route.save!

		customer_routes -= [move_customer_route]
		index = 0
		customer_routes.each do |customer_route|
			index +=1 if index == to_index 

			if customer_route.row_order != index
				customer_route.row_order = index
				customer_route.save!
			end

			index +=1
		end
	end

	def self.destroy_and_reorder(customer_route)
		customer_routes = CustomerRoute.where(:delivery_person_id => customer_route.delivery_person_id, 
																					:wday=>customer_route.wday).order(:row_order)
		customer_route.destroy
		customer_routes.each_with_index do |customer_route, index|
			if customer_route.row_order != index
				customer_route.row_order = index
				customer_route.save!
			end
		end
	end
end
