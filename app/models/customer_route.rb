class CustomerRoute < ActiveRecord::Base
	validates_inclusion_of :wday, :in=> %w(monday tuesday wednesday thursday friday saturday sunday)
	belongs_to :customer
	belongs_to :delivery_person

	def self.reorder(delivery_person, wday, move_customer_route, to_index)

		customer_routes = delivery_person.customer_routes.where(:wday=>wday).order(:row_order)
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
end
