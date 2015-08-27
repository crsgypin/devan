class CustomersController < ApplicationController
	before_action :set_customer, :only=>[:show,:edit,:update,:destroy]
	before_action :authenticate_user!, :except=>[:index,:show]

	def index

		@customers = Customer.includes(:phones,:addresses=>[:city]).joins(:phones,:addresses=>[:city])
		# @customers = @customers.where("addresses.city_id = #{@customer_city}") if @customer_city >0
		@customers = @customers.where(:status=>"經營中")
		@customers = @customers.page(params[:page]).per(30)

		@map_customers = Customer.includes(:addresses=>[:city]).joins(:addresses=>[:city])
		@map_customers = @map_customers.where("address <> ''").first(10)
		set_markers(@map_customers)

		@date_list = []
		5.times do |index|
			@date_list << [index.day.ago.strftime('%m/%d %A'), index]
		end

	end

	def update_date
		before_day = params[:day].to_i.day
		wday = before_day.ago.strftime('%A').downcase

		delivery_person = DeliveryPerson.first
		@map_customers = Customer.joins(:customer_routes).where("customer_routes.wday = ?", wday).where("customer_routes.delivery_person_id = ?", delivery_person.id)
		@map_customers = @map_customers.includes(:addresses=>[:city])
		set_markers(@map_customers)

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
	def set_markers(customers)
		customer_markers = [];
		customers.each do |customer|
			lat = customer.addresses[0].lat
			lng = customer.addresses[0].lng
			info = customer.name
			customer_markers << {:lat=>lat, :lng=>lng,:info=>info}
		end

		@markers = customer_markers.to_json
	end
end

