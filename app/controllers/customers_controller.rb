class CustomersController < ApplicationController
	before_action :set_customer, :only=>[:show,:edit,:update,:destroy]

	def index
		@customers = Customer.includes(:phones,:addresses=>[:city]).page(params[:page]).per(15)

	end

	def search
		update_session_search

		states = []
		states<< "customers.code LIKE '%#{@customer_search}%'" if @customer_code
		states<< "customers.name LIKE '%#{@customer_search}%'" if @customer_name
		states<< "address LIKE '%#{@customer_search}%'" if @customer_address
		states<< "number LIKE '%#{@customer_search}%'" if @customer_phone
		sql = "#{states.join(" OR ")}"
		@customers = Customer.includes(:phones,:addresses=>[:city]).joins(:phones)
		@customers = @customers.where(sql)
		@customers = @customers.where("addresses.city_id = #{@customer_city}") if @customer_city >0
		# @customers = @customers.where(["customers.name like ? OR address like ? OR number LIKE ?","%#{@customer_search}%","%#{key_address}%", "%#{key_number}%"])

	end

	def new
		@customer = Customer.new
		@customer.phones.new
		@customer.addresses.new
		@customer.faxes.new
	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
			flash[:notice] = "客戶#{@customer.name} 儲存成功"
			redirect_to customer_path(@customer)
		else

			render 'customers/new'
		end

	end

	def show
	end

	def edit

	end

	def update
		if @customer.update(customer_params)
			flash[:notice] = "客戶#{@customer.name} 修改成功"
			redirect_to customer_path(@customer)
		else

			render 'customers/edit'
		end

	end

private
	def set_customer
		@customer = Customer.find(params[:id])
	end

	def customer_params
		params.require(:customer).permit(:code, :name, :description, :status,
															:phones_attributes=>[:number],
															:faxes_attributes=>[:number],
															:addresses_attributes=>[:address,:city_id,:district_id] )

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
			end
		end

		@customer_search = session[:customer_search] ||= ""
		@customer_code = session[:customer_code] ||= true
		@customer_phone = session[:customer_phone] ||= true
		@customer_name = session[:customer_name] ||= true
		@customer_address = session[:customer_address] ||= true
		@customer_city = session[:customer_city] ||= 0
	end
end
