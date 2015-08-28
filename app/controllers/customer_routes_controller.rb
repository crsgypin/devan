class CustomerRoutesController < ApplicationController
	before_action :authenticate_user!
	before_action :check_editor?

	def index
		@delivery_people = DeliveryPerson.on_job.includes(:customer_routes)
		@wday = params[:wday] ? params[:wday] : Date.today.strftime('%A')
	end

	def create
		@delivery_person = DeliveryPerson.find(params[:delivery_person_id])
		@customer = Customer.find(params[:customer_id])
		@wday = params[:wday].downcase
		@customer_route = CustomerRoute.create(:customer=>@customer, :delivery_person=>@delivery_person, :wday=>@wday)

		CustomerRoute.move_order(@customer_route, 0)
		respond_to do |format|
			format.json {render :json=>{:template=> render_to_string(:partial=>"customer_routes/route_list.html", :locals=>{:delivery_person=>@delivery_person,:wday=>@wday})}}
		end
	end

	def destroy
		@customer_route = CustomerRoute.find(params[:id])
		@delivery_person = @customer_route.delivery_person
		@wday = @customer_route.wday
		CustomerRoute.destroy_and_reorder(@customer_route)
		respond_to do |format|
			format.json {render :json=>{:template=> render_to_string(:partial=>"customer_routes/route_list.html", :locals=>{:delivery_person=>@delivery_person, :wday=>@wday})}}
		end
	end


	def move
		@move_customer_route = CustomerRoute.find(params[:customer_route_id])
		@to_index = params[:to_index].to_i
		
		CustomerRoute.move_order(@move_customer_route, @to_index)

		respond_to do |format|
			format.json {render :json=>{:result=>true}}
		end
	end

private
	def check_editor?
		if !current_user.editor?
			redirect_to root_path
		end
	end
end
