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



end
