require "rails_helper"

RSpec.describe DeliveryPerson, type: :model do

  describe "check create" do
  	before do
      DeliveryPerson.create(:code=>"AA",:name=>"小紅",:status=>"在職")
      DeliveryPerson.create(:code=>"BB",:name=>"馬克",:status=>"離職")
  	end

  	it "shoud be saved" do
  		expect(DeliveryPerson.count).to eq(2)
  	end
  end

  describe "check inclusion" do
    before do
      DeliveryPerson.create(:code=>"AA",:name=>"Small",:status=>"不到")
    end

    it "should not be saved" do
      expect(DeliveryPerson.count).to eq(0)
    end
  end

  describe "check code uniqueness" do
    before do
      DeliveryPerson.create(:code=>"AA",:name=>"彈丸",:status=>"在職")
      DeliveryPerson.create(:code=>"AA",:name=>"米紅",:status=>"在職")
    end

    it "should save the first" do
      expect(DeliveryPerson.count).to eq(1)
    end
  end

end
