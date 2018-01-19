require 'rails_helper'
RSpec.describe Order, type: :model do
  context 'validations' do
		it 'is a valid order' do
			FactoryGirl.build(:order).should be_valid
		end
		
		it 'is invalid without order number' do
			FactoryGirl.build(:order, order_number: nil).should_not be_valid
		end
		
		it 'is invalid without a payment mode' do
			FactoryGirl.build(:order, payment_mode: nil).should_not be_valid
		end

    it 'validates order payment mode' do
      FactoryGirl.build(:order, payment_mode: "Free").should_not be_valid 
    end 

    it 'validates order number to be numeric' do
      FactoryGirl.build(:order, order_number: "rtyw").should_not be_valid 
    end 
	end

	context 'assosiation test' do
    it 'should belongs to user' do
	    user = FactoryGirl.create(:user)
	    order = FactoryGirl.create(:order,user_id:user.id)
	    order.user.id.should eq user.id
    end

    it 'should not belong to invalid user'do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      order = FactoryGirl.create(:order ,user_id:user1.id)
      order.user.id.should eq user1.id
      order.user.id.should_not eq user2.id
    end

    it "should have one invoice" do
      order = FactoryGirl.create(:order)
      invoice = FactoryGirl.create(:invoice, order_id: order.id)
      invoice.order.should eq order
    end
  end
end