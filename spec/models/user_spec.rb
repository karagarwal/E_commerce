require 'rails_helper'
RSpec.describe User, type: :model do
  context 'validations' do
		it 'is a valid user' do
			FactoryGirl.build(:user).should be_valid
		end
		
		it 'is invalid without user name' do
			FactoryGirl.build(:user, name: nil).should_not be_valid
		end
		
		it 'is invalid without a user address' do
			FactoryGirl.build(:user, address: nil).should_not be_valid
		end

		it 'is invalid without a user phone' do
			FactoryGirl.build(:user, phone: nil).should_not be_valid
		end

    it 'is invalid without a user gender' do
      FactoryGirl.build(:user, gender: nil).should_not be_valid
    end

		it 'is invalid without a username' do
			FactoryGirl.build(:user, username: nil).should_not be_valid
		end

		it 'is invalid without a password' do
			FactoryGirl.build(:user, password: nil).should_not be_valid
		end

    it 'validates user phone length' do
      FactoryGirl.build(:user, phone: '12345').should_not be_valid
    end

    it 'validates password length' do
      FactoryGirl.build(:user, password: 'qwerty').should_not be_valid
    end

    it 'validates username format' do
      FactoryGirl.build(:user, username: 'ewqdsfdsa_gmail.com').should_not be_valid
    end
	end

	context 'assosiation test' do
    it "should have many orders" do
      user = FactoryGirl.create(:user)
      order = FactoryGirl.create(:order, user_id: user.id)
      user.orders.should include order
		end

    it "should not have unincluded orders" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      order1 = FactoryGirl.create(:order, user_id: user1.id)
      order2 = FactoryGirl.create(:order, user_id: user2.id)
      user1.orders.should include order1
      user1.orders.should_not include order2
      user2.orders.should include order2
      user2.orders.should_not include order1
    end
  end
end