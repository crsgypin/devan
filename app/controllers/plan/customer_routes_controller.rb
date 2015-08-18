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

	def create
		@delivery_person = DeliveryPerson.find(params[:delivery_person_id])
		@customer = Customer.find(params[:customer_id])
		@wday = params[:wday].downcase
		@customer_route = CustomerRoute.create(:customer=>@customer, :delivery_person=>@delivery_person, :wday=>@wday)

		CustomerRoute.reorder(@customer_route, 0)
		respond_to do |format|
			format.json {render :json=>{:template=> render_to_string(:partial=>"plan/customer_routes/route_list", :locals=>{:delivery_person=>@delivery_person})}}
		end
	end

	def move
		@move_customer_route = CustomerRoute.find(params[:customer_route_id])
		@to_index = params[:to_index].to_i
		
		CustomerRoute.reorder(@move_customer_route, @to_index)

		respond_to do |format|
			format.json {render :json=>{:result=>true}}
		end
	end

	def destroy

	end

end
