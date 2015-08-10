class ManufacturersController < ApplicationController
	before_action :set_manufacturer, :only=>[:show, :edit, :update, :destroy]

	def index
		@manufacturers = Manufacturer.all
	end

	def show

	end

	def new
		@manufacturer = Manufacturer.new
	end

	def create
		@manufacturer = Manufacturer.new(manufacturer_params)
		if @manufacturer.save

			redirect_to manufacturer_path(@manufacturer)
		else

			render 'manufacturers/new'
		end

	end

	def edit

	end

	def update
		if @manufacturer.update(manufacturer_params)
			
			redirect_to manufacturer_path(@manufacturer)
		else

			render 'manufacturers/edit'
		end


	end


private
	def set_manufacturer
		@manufacturer = Manufacturer.find(params[:id])
	end

	def manufacturer_params
		params.require(:manufacturer).permit(:name,:description, 
											:manufacturer_keys_attributes=>[:id, :name, :note, :mapping_key],
											:phones_attributes=>[:id, :number],
											:faxes_attributes=>[:id, :number],
											:addresses_attributes=>[:id, :address,:city_id,:district_id] )

	end

end
