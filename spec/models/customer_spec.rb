require "rails_helper"

RSpec.describe Customer, type: :model do

  before do
    @manufacturer = Manufacturer.create(:name=>"aa")
    @customer = Customer.create(:name=>"aa")
    @daily_form = DailyForm.create(:date=> Date.today)

  end

  describe "刪除測試: " do
  	before do
      @daily_form.form_values.create(:manufacturer=>@manufacturer, :customer=>@customer, :delivery_person_id=>1,:key1=>123)
      @daily_form.form_values.create(:manufacturer=>@manufacturer, :customer=>@customer, :delivery_person_id=>1,:key1=>44)
      @customer.destroy
  	end

  	it "有 form value 不能刪除" do
  		expect(Customer.count).to eq(1)
  		expect(FormValue.count).to eq(2)
  	end
  end

  describe "刪除測試: " do 
    before do
      @customer.destroy
    end

    it "沒有 form value 可以刪除" do
      expect(Customer.count).to eq(0)
    end
  end

  describe "address儲存測試: " do
    before do
      @customer.build_address(:address=>"台北市")
      @customer.save
    end

    it "address 一併儲存" do
      expect(Customer.count).to eq(1)
      expect(Address.count).to eq(1)
    end
  end

  describe "address刪除測試: " do
    before do
      @customer.build_address(:address=>"台北市")
      @customer.save
      @customer.destroy
    end

    it "address 一併刪除" do
      expect(Customer.count).to eq(0)
      expect(Address.count).to eq(0)
    end
  end
  
end



