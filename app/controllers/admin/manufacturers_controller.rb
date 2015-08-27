class Admin::ManufacturersController < ApplicationController
	before_action :set_manufacturer, :only=>[:show, :edit, :update, :destroy]
	before_action :authenticate_user!, :except=>[:index,:show]

	def index
		@manufacturers = Manufacturer.all
	end

	def show

	end

	def new
		@manufacturer = Manufacturer.new
		@manufacturer.phones.new
		@manufacturer.addresses.new
		@manufacturer.faxes.new
	end

	def create
		@manufacturer = Manufacturer.new(manufacturer_params)
		if @manufacturer.save

			redirect_to admin_manufacturers_path
		else

			render 'admin/manufacturers/new'
		end

	end

	def edit
		@manufacturer.addresses.new if @manufacturer.addresses.count ==0
		@manufacturer.phones.new if @manufacturer.phones.count ==0
		@manufacturer.faxes.new if @manufacturer.faxes.count ==0
	end

	def update
		if @manufacturer.update(manufacturer_params)
			
			redirect_to admin_manufacturers_path
		else

			render 'admin/manufacturers/edit'
		end
	end

	def destroy
		if @manufacturer.destroy
			flash[:success] = "#{@manufacturer.name} 已被移除"
			redirect_to admin_manufacturers_path
		else
			flash[:fail] = "#{@manufacturer.name} 移除失敗"
			render 'admin/manufacturers/edit'
		end
	end


private
	def set_manufacturer
		@manufacturer = Manufacturer.find(params[:id])
	end

	def manufacturer_params
		params.require(:manufacturer).permit(:name,:description, 
											:manufacturer_keys_attributes=>[:id, :name, :note, :mapping_key],
											:phones_attributes=>[:id, :number,:_destroy],
											:faxes_attributes=>[:id, :number,:_destroy],
											:addresses_attributes=>[:id, :address,:city_id,:district_id,:_destroy] )

	end

end
