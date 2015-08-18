require 'rails_helper'

RSpec.describe CustomerRoute, type: :model do

	before do 
		@delivery_person = DeliveryPerson.create(:name=>"lopin")
		@customer = Customer.create(:name=>"wafire")
	end

  describe "新增 Monday" do
  	before do
  		CustomerRoute.create(:delivery_person=>@delivery_person, :customer=>@customer, :wday=>"Monday")
  	end

  	it "Monday 要小寫" do
  		expect(CustomerRoute.count).to eq(0)
  	end
  end

  describe "新增 monday friday" do
  	before do
  		CustomerRoute.create(:delivery_person=>@delivery_person, :customer=>@customer, :wday=>"monday")
  		CustomerRoute.create(:delivery_person=>@delivery_person, :customer=>@customer, :wday=>"friday")
  	end

  	it "monday 寫入成功" do
  		expect(CustomerRoute.count).to eq(2)
  	end
  end

end
