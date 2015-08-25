
require "rails_helper"

RSpec.describe Manufacturer, type: :model do

  before do
  	@mamufacturer = Manufacturer.create(:name=>"aa")
      @mamufacturer.form_values.create(:key1=>32)
  end

  describe "check destroy" do

  	before do 
      @mamufacturer.destroy
	  end

    it "有 form_values的時候，manufacturer無法刪除" do
      expect(Manufacturer.count).to eq(1)
      expect(FormValue.count).to eq(1)
    end
  end

end

