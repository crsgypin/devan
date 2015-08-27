class CustomersController < ApplicationController
	before_action :authenticate_user!, :except=>[:index,:show]

	def index

		@customers = Customer.includes(:phones,:addresses=>[:city]).joins(:phones,:addresses=>[:city])
		# @customers = @customers.where("addresses.city_id = #{@customer_city}") if @customer_city >0
		@customers = @customers.where(:status=>"經營中")
		@customers = @customers.page(params[:page]).per(30)

		delivery_person = DeliveryPerson.first
		set_customer_routes(Date.today, delivery_person)
	end

	def update_date
		before_day = params[:day].to_i.day.ago
		delivery_person = DeliveryPerson.first
		set_customer_routes(date, delivery_person)

		respond_to do |format|
			format.json {render :json=> {
												:markers=> @markers,
												:template=> render_to_string(:partial=>"customers/customer_route_list.html", :locals=>{:map_customers=>@map_customers})}}
		end

	end

	def profiles

		@customers = Customer.includes(:phones,:addresses=>[:city]).joins(:phones,:addresses=>[:city])
		# @customers = @customers.where("addresses.city_id = #{@customer_city}") if @customer_city >0
		@customers = @customers.page(params[:page]).per(30)
		# @customers = @customers.where(["customers.name like ? OR address like ? OR number LIKE ?","%#{@customer_search}%","%#{key_address}%", "%#{key_number}%"])
	end

	def update_status
		@customer = Customer.find(params[:id])
		@customer.update(:status=>params[:status])
		respond_to do |format|
			format.json {render :json=>{:result=>"success"}}
		end

	end



	def show
	end

	def edit

	end

private 
	def set_customer_routes(date,delivery_person)
		wday = date.strftime('%A').downcase
    @customer_routes = CustomerRoute.includes(:delivery_person,:customer=>[:addresses]).order(:row_order)
    @customer_routes = @customer_routes.where(:wday=>wday,:delivery_person=>delivery_person)

		customer_markers = [];
		@customer_routes.each do |customer_route|
			customer = customer_route.customer
			if customer.addresses[0].lat != nil
				lat = customer.addresses[0].lat
				lng = customer.addresses[0].lng
				info = customer.name
			else
				lat = 25
				lng = 121.5
				info = customer.name
			end
			customer_markers << {:lat=>lat, :lng=>lng,:info=>info}
		end
		@markers = customer_markers.to_json
	end
end

