class DailyFormsController < ApplicationController
	before_action :authenticate_user!, :except=>[:index,:show]
	layout "form_print", only: [:print]

	def index
		@daily_forms = DailyForm.order(:date=>:desc, :manufacturer_id=>:asc)
		@daily_forms = @daily_forms.includes(:form_values,:manufacturer,:users)
		@daily_forms = @daily_forms.page(params[:page]).per(15)

	end

	def show
		daily_forms = DailyForm.includes(:manufacturer=>[:manufacturer_keys], :form_values => [:delivery_person, :customer])
		@daily_form = daily_forms.find(params[:id])
		@manufacturer = @daily_form.manufacturer
	end

	def print
		daily_forms = DailyForm.includes(:manufacturer=>[:manufacturer_keys], :form_values => [:delivery_person, :customer])
		@daily_form = daily_forms.find(params[:id])
		@manufacturer = @daily_form.manufacturer				
	end

	def new
		if params[:daily_form] && params[:daily_form][:manufacturer_id] && params[:daily_form][:date]
			@daily_form = DailyForm.find_or_create_by(
										:manufacturer_id => params[:daily_form][:manufacturer_id],
										:date => params[:daily_form][:date] )

			20.times do |index|
				@daily_form.form_values.find_or_create_by(:form_value_index => index + 1)
			end
			@manufacturer = @daily_form.manufacturer
			set_customer_list
			set_delivery_people_list

			render 'daily_forms/edit'
		else
			render :text => "no result"
		end
	end

	def edit
		@daily_form = DailyForm.includes(:manufacturer=>[:manufacturer_keys]).find(params[:id])
		@manufacturer = @daily_form.manufacturer

		set_customer_list
		set_delivery_people_list

		render 'daily_forms/edit'
	end

	def update
		@daily_form = DailyForm.find(params[:id])
		@daily_form.update(daily_form_params)

		respond_to do |format|
			format.html {redirect_to daily_form_path(@daily_form)}
			format.json {render :json=> {:errors=>"ok"}}
		end
	end

	def destroy
		@daily_form = DailyForm.find(params[:id])
		@daily_form.destroy

		redirect_to daily_forms_path
	end

	def check_daily_form
		@daily_form = DailyForm.find_by(
									:manufacturer_id => params[:daily_form][:manufacturer_id],
									:date => params[:daily_form][:date] )

		result = @daily_form.present?

		respond_to do |format|
			format.json {render :json=>{:result=>result}}
		end
	end

	def add_row
		@daily_form = DailyForm.find(params[:id])
		last_form_value_index = @daily_form.form_values.last.form_value_index
		@form_value = @daily_form.form_values.create(:form_value_index=>last_form_value_index+1)
		@form_keys = @daily_form.manufacturer.manufacturer_keys
		set_customer_list
		set_delivery_people_list

		respond_to do |format|
			format.json { render :json => {:data=>@form_value.to_json, :template=> (render_to_string :partial=>'daily_forms/single_row_edit.html', :locals=>{:form_value=>@form_value,:form_keys=>@form_keys}) }}
		end
	end

private
	def set_manufacturer
		@manufacturer = params[:manufacturer_id]
	end

	def set_date
		@date = params[:date]
	end

	def set_customer_list
		@customer_list= Customer.all.map{|c| ["#{c.code}-#{c.name}",c.id]}.unshift(["",nil])
	end

	def set_delivery_people_list
		@delivery_people_list = DeliveryPerson.all.map{ |p| ["#{p.code}-#{p.name}",p.id]}.unshift("",nil)		
	end

	def daily_form_params
		params.require(:daily_form).permit(:form_values_attributes=>[:id,:form_value_index,:daily_form_id,:customer_id,
																								:delivery_person_id, :key1, :key2, :key3, :key4, :key5,
																								:key6, :key7, :key8, :note])

	end


end
