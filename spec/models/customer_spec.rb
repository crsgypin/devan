require "rails_helper"

RSpec.describe Customer, type: :model do

  before do
    @manufacturer = Manufacturer.create(:name=>"aa")
    @daily_form = @manufacturer.daily_forms.create(:date=> Date.today)

  end

  describe "確認刪除: " do

  	before do
      @customer = Customer.create(:name=>"aa")
      @daily_form.form_values.create(:customer=>@custoemr, :delivery_person_id=>1,:key1=>123)
      @daily_form.form_values.create(:customer=>@customer, :delivery_person_id=>1,:key1=>44)
      @customer.destroy
  	end

  	it "有 form value 不能刪除" do
  		expect(Customer.count).to eq(1)
  		expect(FormValue.count).to eq(2)
  	end
  end

  describe "確認刪除: " do 
    before do
      @customer = Customer.create(:name=>"aa")
      @customer.destroy
    end

    it "沒有 form value 可以刪除" do
      expect(Customer.count).to eq(0)
    end
  end
end
