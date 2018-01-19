require 'rails_helper'
RSpec.describe Item, type: :model do
  context 'validations' do
		it 'is a valid item' do
			FactoryGirl.build(:item).should be_valid
		end
		
		it 'is invalid without name' do
			FactoryGirl.build(:item, name: nil).should_not be_valid
		end
		
		it 'is invalid without a price' do
			FactoryGirl.build(:item, price: nil).should_not be_valid
		end
		
		it 'is invalid without a weight' do
			FactoryGirl.build(:item, weight: nil).should_not be_valid
		end

    it 'is invalid without a brand' do
      FactoryGirl.build(:item, brand: nil).should_not be_valid
    end

    it 'validates item price to be numeric' do
      FactoryGirl.build(:item, price: "wsd").should_not be_valid 
    end 

    it 'validates item weight to be numeric' do
      FactoryGirl.build(:item, weight: "qwe").should_not be_valid 
    end 
	end

	context 'assosiation test' do
    it 'should belongs to category' do
	    category = FactoryGirl.create(:category)
	    item = FactoryGirl.create(:item,category_id:category.id)
	    item.category.id.should eq category.id
    end

    it 'should not belong to invalid category'do
      category1 = FactoryGirl.create(:category)
      category2 = FactoryGirl.create(:category)
      item = FactoryGirl.create(:item ,category_id:category1.id)
      item.category.id.should eq category1.id
      item.category.id.should_not eq category2.id
    end

    it "should have many orders" do
      item = FactoryGirl.create(:item)
      order1 = FactoryGirl.create(:order, item_id: item.id)
      order2 = FactoryGirl.create(:order, item_id: item.id)
      item.orders.should include order1
      item.orders.should include order2
		end
		
    it "should not have unincluded orders" do
      item1 = FactoryGirl.create(:item)
      item2 = FactoryGirl.create(:item)
      order1 = FactoryGirl.create(:order, item_id: item1.id)
      order2 = FactoryGirl.create(:order, item_id: item2.id)
      item1.orders.should include order1
      item1.orders.should_not include order2
      item2.orders.should include order2
      item2.orders.should_not include order1
    end
  end
end