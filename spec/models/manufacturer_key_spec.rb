
require "rails_helper"

RSpec.describe ManufacturerKey, type: :model do

  before do
  	@manufacturer = Manufacturer.create(:name=>"aa")
  end

  describe "#check the same save" do

  	before do 
	  	@manufacturer.manufacturer_keys.create(:name=>"現金",:mapping_key=>1)
	  	@manufacturer.manufacturer_keys.create(:name=>"月收",:mapping_key=>1)	  	
	  end

    it "manufacturer_keys 總數目" do
      expect( @manufacturer.manufacturer_keys.count).to eq(1)
    end
  end

  describe "#check different saves" do
  	before do 
	  	@manufacturer.manufacturer_keys.create(:name=>"現金",:mapping_key=>1)
	  	@manufacturer.manufacturer_keys.create(:name=>"月收",:mapping_key=>2)	  	
	  end

    it "manufacturer_keys 總數目" do
      expect( @manufacturer.manufacturer_keys.count).to eq(2)
    end
  end
end

