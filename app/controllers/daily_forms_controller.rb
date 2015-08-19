class DailyFormsController < ApplicationController
	before_action :authenticate_user!, :except=>[:index,:show]
	layout "form_print", only: [:print]

	def index
		@daily_forms = DailyForm.includes(:form1_values=>[:manufacturer,:delivery_person,:customer])
		@daily_forms = @daily_forms.includes(:form2_values=>[:manufacturer,:delivery_person,:customer])
		@daily_forms = @daily_forms.page(params[:page]).per(15)

		@daily_form = @daily_forms.find_or_create_by(:date=> Date.today)
		@form1_values = @daily_form.form1_values
		@form2_values = @daily_form.form2_values

		20.times do |index|
			if @daily_form.form1_values.length <= index
				@daily_form.form1_values.new				
			end

			if @daily_form.form2_values.length <= index
				@daily_form.form2_values.new				
			end
		end

	end

	def update_form1
		@daily_form = DailyForm.find(params[:id])

		id_mapping = {}
		if params[:daily_form]
			params[:daily_form][:form1_values_attributes].each do |key,value|
				if value[:id] == "" || value[:id] == nil
					form1_value = @daily_form.form1_values.create
					id_mapping[key] = form1_value.id #feedback id_mapping for browser to registor id into new row
				else
					form1_value = @daily_form.form1_values.find(value[:id].to_i)
				end	
				Form1Value.attribute_names.each do |a|
					form1_value[a] = value[a] if value[a] && a!= "id"
				end
				form1_value.save!
				form1_value.form_value_users.find_or_create_by(:user=>current_user)
			end
		end

		respond_to do |format|
			format.json {render :json=>{:result=>id_mapping.to_json}}
		end
	end

	def edit_form1

		@daily_form = DailyForm.find(params[:id])
		@form1_values = @daily_form.form1_values					

		20.times do |index|
			if @daily_form.form1_values.length <= index
				@daily_form.form1_values.new				
			end
		end

		set_selection_list

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form1_values_edit.html",:locals=>{:daily_form=>@daily_form, :form1_values=>@form1_values})}}
		end

	end

	def show_form1
		@daily_form = DailyForm.find(params[:id])
		@form1_values = @daily_form.form1_values					

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form1_values_show.html",:locals=>{:daily_form=>@daily_form, :form1_values=>@form1_values})}}
		end

	end

	def delete_form1_value
		@daily_form = DailyForm.find(params[:id])
		@form1_value = @daily_form.form1_values.find(params[:form_value_id])
		@form1_value.destroy
		respond_to do |format|
			format.json {render :json=>{:result=>"OK"}}
		end
	end

	def new_form1_value
		@daily_form = DailyForm.find(params[:id])
		@form1_value = @daily_form.form1_values.new
		@index = params[:index].to_i

		set_selection_list
		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form1_values_edit_row.html",:locals=>{:daily_form=>@daily_form, :form1_value=>@form1_value, :index=>@index})}}
		end
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

	def update1
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

	def set_selection_list
		@customer_list = Customer.active.map{|c| {:id=>c.id, :text=>"#{c.code}-#{c.name}"}}
		@delivery_people_list = DeliveryPerson.on_job.map{|d| ["#{d.code}-#{d.name}", d.id]}
		@manufacturer_list = Manufacturer.all.map{|m| [m.name, m.id]}
	end


	def daily_form_params
		params.require(:daily_form).permit(:form2_values_attributes=>[:id,:form_value_index,:daily_form_id,:customer_id,
																								:delivery_person_id, :key1, :key2, :key3, :key4, :key5, :key6, :note],
																			 :form1_values_attributes=>[:id,:form_value_index,:daily_form_id,:customer_id,
																								:delivery_person_id, :basket, :note, :manufacturer_id])

	end


end
