require "rails_helper"

RSpec.describe ManufacturerKey, type: :model do

  before do
  	@daily_form = DailyForm.create(:date=> Date.today)
  end

  describe "check delete" do

  	before do
  		@daily_form.form2_values.create(:customer_id=>1, :delivery_person_id=>1,:key1=>123)
  		@daily_form.form2_values.create(:customer_id=>1, :delivery_person_id=>1,:key1=>44)
  		@daily_form.destroy
  	end

  	it "form value 一起刪除" do
  		expect(Form1Value.count).to eq(0)
  		expect(DailyForm.count).to eq(0)
  	end
  end

end
