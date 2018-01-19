require 'rails_helper'
RSpec.describe Invoice, type: :model do
  context 'validations' do
		it 'is a valid invoice' do
			FactoryGirl.build(:invoice).should be_valid
		end
		
		it 'is invalid without invoice_number' do
			FactoryGirl.build(:invoice, invoice_number: nil).should_not be_valid
		end
		
		it 'is invalid without a amount' do
			FactoryGirl.build(:invoice, amount: nil).should_not be_valid
		end

    it 'validates invoice number to be numeric' do
      FactoryGirl.build(:invoice, invoice_number: "sdfgh").should_not be_valid 
    end 

    it 'validates invoice amount to be numeric' do
      FactoryGirl.build(:invoice, amount: "drghg").should_not be_valid 
    end 
	end

	context 'assosiation test' do
    it 'should belongs to order' do
	    order = FactoryGirl.create(:order)
	    invoice = FactoryGirl.create(:invoice,order_id:order.id)
	    invoice.order.id.should eq order.id
    end

    it 'should not belong to invalid order'do
      order1 = FactoryGirl.create(:order)
      order2 = FactoryGirl.create(:order)
      invoice = FactoryGirl.create(:invoice ,order_id:order1.id)
      invoice.order.id.should eq order1.id
      invoice.order.id.should_not eq order2.id
    end
  end
end