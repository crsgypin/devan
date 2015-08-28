require 'rails_helper'

RSpec.describe Permission, type: :model do

  describe "save User, then save permission" do
	  before do
	  	@user = User.create(:email=>"test1@gmail.com",:password=>"qwerty1234")
	  end

  	it "should have permission" do
  		expect(User.count).to eq(1)
  		expect(Permission.count).to eq(1)
  	end
  end

  describe "destroy User, then destroy permission" do
  	before do 
	  	@user = User.create(:email=>"test1@gmail.com",:password=>"qwerty1234")
	  	@user.destroy
	  end

    it "should have no permission data" do
  		expect(User.count).to eq(0)	
  		expect(Permission.count).to eq(0)
    end
  end
end
