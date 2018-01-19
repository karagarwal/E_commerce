require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  context 'GET index' do
    it 'should show all invoices' do
      request.accept = "application/json"
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new' do
    it 'should get new invoice successfully' do
      request.accept = "application/json"
      get :new
      assigns(:invoice).id.should eq nil
      assigns(:invoice).invoice_number.should eq nil
      assigns(:invoice).amount.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show invoice successfully' do
      request.accept = "application/json"
      invoice = FactoryGirl.create(:invoice)
      get :show, { id: invoice.id }
      response.should have_http_status(:ok)
    end

    it 'should shouw invoice unsuccessfully' do
      request.accept = "application/json"
      get :show, { id: ''}
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create invoice successfully' do
      request.accept = "application/json"
      invoice = FactoryGirl.create(:invoice)
      post :create, { invoice: { order_id: invoice.order.id, invoice_number: invoice.invoice_number, amount: invoice.amount } }
      response.should have_http_status(:ok)
    end

    it 'should create invoice unsuccessfully' do
      request.accept = "application/json"
      post :create, { invoice: { order_id: '', invoice_number: '', amount: '' } }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create invoice with invalid order' do
      request.accept = 'application/json'
      invoice = FactoryGirl.create(:invoice)
      post :create, invoice: { order_id: 'qq', invoice_number: invoice.invoice_number, amount: invoice.amount }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST edit' do
    it 'should get correct invoice successfully' do
      request.accept = 'application/json'
      invoice = FactoryGirl.create(:invoice)
      get :edit, id: invoice.id
      assigns(:invoice).should eq invoice
      response.should have_http_status(:ok)
    end

    it 'should not get invoice with invalid id' do
      request.accept = 'application/json'
      get :edit, id: '12345'
      response.should have_http_status(:not_found)
    end
  end

  context 'PUT update' do
    it 'should update invoice successfully' do
      request.accept = "application/json"
      invoice = FactoryGirl.create(:invoice)
      put :update, { id: invoice.id, invoice: { order_id: invoice.order.id, invoice_number: invoice.invoice_number, amount: invoice.amount } }
      response.should have_http_status(:ok)
    end

    it 'should update invoice unsuccessfully' do
      request.accept = "application/json"
      invoice = FactoryGirl.create(:invoice)
      put :update, { id: invoice.id, invoice: { order_id: '', invoice_number: '', amount: '' } }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT edit' do
    it 'should not update invoice with invalid category' do
      request.accept = 'application/json'
      invoice = FactoryGirl.create(:invoice)
      post :update, id: invoice.id, invoice: { order_id: 'dd', invoice_number: invoice.invoice_number, amount: invoice.amount  }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete invoice successfully' do
      request.accept = "application/json"
      invoice = FactoryGirl.create(:invoice)
      delete :destroy, { id: invoice.id }
      response.should have_http_status(:ok)
    end

    it 'should delete invoice unsuccessfully' do
      request.accept = "application/json"
      delete :destroy, { id: ''}
      response.should have_http_status(:not_found)
    end
  end	
end