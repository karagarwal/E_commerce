require 'rails_helper'
RSpec.describe Category, type: :model do
  context 'validations' do
		it 'is a valid category' do
			FactoryGirl.build(:category).should be_valid
		end
		
		it 'is invalid without name' do
			FactoryGirl.build(:category, name: nil).should_not be_valid
		end
	end

	context 'assosiation test' do
    it "should have many items" do
      category = FactoryGirl.create(:category)
      item1 = FactoryGirl.create(:item, category_id: category.id)
      item2 = FactoryGirl.create(:item, category_id: category.id)     
      category.items.should include item1
      category.items.should include item2
		end
		
    it "should not have unincluded items" do
      category1 = FactoryGirl.create(:category)
      category2 = FactoryGirl.create(:category)
      item1 = FactoryGirl.create(:item, category_id: category1.id)
      item2 = FactoryGirl.create(:item, category_id: category2.id)
      category1.items.should include item1
      category1.items.should_not include item2
      category2.items.should include item2
      category2.items.should_not include item1
    end
  end
end