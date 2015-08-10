require "rails_helper"

RSpec.describe ManufacturerKey, type: :model do

  before do
  	@manufacturer = Manufacturer.create(:name=>"aa")
  	@daily_form = @manufacturer.daily_forms.create(:date=> Date.today)
  end

  describe "check delete" do

  	before do
  		@daily_form.form_values.create(:customer_id=>1, :delivery_person_id=>1,:key1=>123)
  		@daily_form.form_values.create(:customer_id=>1, :delivery_person_id=>1,:key1=>44)
  		@daily_form.destroy
  	end

  	it "form value 一起刪除" do
  		expect(FormValue.count).to eq(0)
  		expect(DailyForm.count).to eq(0)
  	end
  end

end
