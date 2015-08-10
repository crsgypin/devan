class DistrictsController < ApplicationController
	before_action :set_district, :only=>[:show, :edit,:update,:destroy]

	def index
		@districts = District.order(:city_id)
	end

	def show
	end

	def new
		@district = District.new
	end

	def create
		@district = District.new(district_params)
		if @district.save
			flash[:success] = "#{@district.name} 新增成功"
			redirect_to district_path(@district)
		else
			flash[:fail] = "#{@district.name} 新增失敗"
			render 'districts/new'
		end
	end

	def edit
	end

	def update
		if @district.update(district_params)
			flash[:success] = "#{@district.name} 更新成功"
			redirect_to district_path(@district)
		else
			flash[:fail] = "#{@district.name} 更新失敗"
			render 'districts/edit'
		end
	end

	def destroy

		if @district.destroy
			flash[:success] = "#{@district.name} 已被移除"
			redirect_to districts_path
		else
			flash[:fail] = "#{@district.name} 移除失敗"
			render 'districts/show'
		end
	end

private
	
	def set_district
		@district = District.find(params[:id])
	end

	def district_params
		params.require(:district).permit(:city_id, :name, :postal_code)
	end

end
