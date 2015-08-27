class Admin::CustomersController < ApplicationController
	before_action :set_customer, :only=>[:show,:edit,:update,:destroy]
	before_action :authenticate_user!

	def index
		# @customers = Customer.all
		@customers = Customer.includes(:addresses,:phones,:faxes,:form_values=>:daily_form)
		@search_key = params[:search]
		set_search if @search_key.present?
		@customers = @customers.page(params[:page]).per(30)

	end

	def show
		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"admin/customers/show.html",:locals=>{:customer=>@customer})}}
		end
	end

	def new
		@customer = Customer.new
		@customer.phones.new
		@customer.addresses.new
		@customer.faxes.new
		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"admin/customers/form.html",:locals=>{:customer=>@customer})}}
		end
	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
			respond_to do |format|
				format.json {render :json=>{:template=>render_to_string(:partial=>"admin/customers/show.html",:locals=>{:customer=>@customer})}}
			end
		else

			render 'customers/new'
		end

	end

	def edit
		@customer.phones.new if @customer.phones.count ==0
		@customer.faxes.new if @customer.faxes.count ==0
		@customer.addresses.new if @customer.addresses.count ==0

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"admin/customers/form.html",:locals=>{:customer=>@customer})}}
		end
	end

	def update
		if @customer.update(customer_params)
			respond_to do |format|
				format.json {render :json=>{:template=>render_to_string(:partial=>"admin/customers/show.html",:locals=>{:customer=>@customer})}}
			end
		end
	end

	def destroy
		@customer.destroy
		respond_to do |format|
			format.json {render :json=>{:result=>"OK"}}
		end
	end

	def set_status
		@customer = Customer.find(params[:id])
		@customer.status = params[:status]
		@customer.save!
		respond_to do |format|
			format.json {render :json=>{:result=>"OK"}}
		end
	end

private
	def set_customer
		@customer = Customer.includes(:addresses,:phones,:faxes,:form_values=>:daily_form).find(params[:id])
	end

	def customer_params
		params.require(:customer).permit(:code, :name, :description, :status,
															:phones_attributes=>[:id,:number,:_destroy],
															:faxes_attributes=>[:id,:number,:_destroy],
															:addresses_attributes=>[:id,:address,:city_id,:district_id,:_destroy],
															:customer_delivery_day_attributes=>[:id,:id, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :unstable_day] )
	end

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

	def update_session_search
		session[:customer_search] = params[:customer_search] if params[:customer_address]
		session[:customer_city] = params[:customer_city].to_i if params[:customer_city]
		list = %w(customer_code customer_name customer_address customer_phone)
		list.each do |item|
			if params[item]
				if params[item].to_i == 1
					session[item] = true
				else
					session[item] = false
				end
			else
				session[item]= true if session[item] ==nil
			end
		end

		@customer_search = session[:customer_search]
		@customer_code = session[:customer_code]
		@customer_phone = session[:customer_phone]
		@customer_name = session[:customer_name]
		@customer_address = session[:customer_address]
		@customer_city = session[:customer_city] ||=0

		states = []
		states<< "customers.code LIKE '%#{@customer_search}%'" if @customer_code
		states<< "customers.name LIKE '%#{@customer_search}%'" if @customer_name
		states<< "address LIKE '%#{@customer_search}%'" if @customer_address
		states<< "number LIKE '%#{@customer_search}%'" if @customer_phone
		@seach_sql = "#{states.join(" OR ")}"

	end
end
