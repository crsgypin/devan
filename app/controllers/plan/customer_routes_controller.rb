class Plan::CustomerRoutesController < ApplicationController

	def index
		@delivery_people = DeliveryPerson.includes(:customer_routes=>[:customer]).joins(:customer_routes=>[:customer])
		@delivery_people.where(:status=>"在職")

		if params[:wday]
			@wday = params[:wday]
			@delivery_people = @delivery_people.where('customer_routes.wday = ?', params[:wday].downcase)
		else
			@wday = "Monday"
			@delivery_people = @delivery_people.where('customer_routes.wday = ?','monday')
		end
		
	end

	def move
		@customer_route = CustomerRoute.find(params[:customer_route_id])

		@customer_route.row_order_position = params[:position]
		@customer_route.save!

		respond_to do |format|
			format.json {render :json=>{:result=>true}}
		end
	end


end
