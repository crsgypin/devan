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
		@move_customer_route = CustomerRoute.find(params[:customer_route_id])
		@delivery_person = DeliveryPerson.find(params[:delivery_person_id])
		@wday = params[:wday].downcase
		@to_index = params[:to_index].to_i
		
		CustomerRoute.reorder(@delivery_person, @wday, @move_customer_route, @to_index)

		respond_to do |format|
			format.json {render :json=>{:result=>true}}
		end
	end

	def destroy
		
	end

end
