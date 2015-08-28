class CustomersController < ApplicationController
	before_action :authenticate_user!
	before_action :check_edit_form?

	def index
		@customers = Customer.active.includes(:phones,:addresses=>[:city])
		@search_key = params[:search]		
		set_search if @search_key.present?
		@customers = @customers.page(params[:page]).per(20)
	end

	def delivery_routes
		@before_day = params[:day] ? params[:day].to_i : 0
		@delivery_person = current_user.delivery_person
		set_customer_routes(@before_day, @delivery_person)

		respond_to do |format|
			format.html
			format.json {render :json=> {
													:markers=> @markers,
													:template=> render_to_string(:partial=>"customers/customer_route_list.html", :locals=>{:map_customers=>@map_customers})}}
		end

	end

private 
	def set_search
		@customers = @customers.joins(:addresses,:phones,:form_values=>:daily_form)
		# @customers = @customers.joins("LEFT JOIN addresses on addresses.address_link_type= 'Customer' and address )
		states = []
		states<< "customers.code LIKE '%#{params[:search]}%'"
		states<< "customers.name LIKE '%#{params[:search]}%'"
		states<< "address LIKE '%#{params[:search]}%'"
		states<< "phones.number LIKE '%#{params[:search]}%'"
		@customers = @customers.where(states.join(" OR ")).group('customers.name')
	end


	def set_customer_routes(before_day,delivery_person)
		wday = before_day.day.ago.strftime('%A').downcase
    @customer_routes = CustomerRoute.includes(:delivery_person,:customer=>[:addresses]).order(:row_order)
    @customer_routes = @customer_routes.where(:wday=>wday,:delivery_person=>delivery_person)

		customer_markers = [];
		@customer_routes.each do |customer_route|
			customer = customer_route.customer
			if customer.addresses[0] && customer.addresses[0].lat != nil
				lat = customer.addresses[0].lat
				lng = customer.addresses[0].lng
				info = "#{customer.name} <br> #{customer.addresses[0].try(:address)}"
			else
				lat = 25
				lng = 121.5
				info = customer.name
			end
			customer_markers << {:lat=>lat, :lng=>lng,:info=>info}
		end
		@markers = customer_markers.to_json
	end

private
	def check_edit_form?
		if !current_user.edit_form?
			redirect_to root_path
		end
	end
end

