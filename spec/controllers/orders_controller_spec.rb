require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  context 'GET index' do
    it 'should show all order successfully' do
      request.accept = "application/json"
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new' do
    it 'should get new order successfully' do
      request.accept = "application/json"
      get :new
      assigns(:order).id.should eq nil
      assigns(:order).order_number.should eq nil
      assigns(:order).payment_mode.should eq nil
      assigns(:order).item_id.should eq nil
      assigns(:order).user_id.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show order successfully' do
      request.accept = "application/json"
      order = FactoryGirl.create(:order)
      get :show, { id: order.id }
      response.should have_http_status(:ok)
    end

    it 'should show order unsuccessfully' do
      request.accept = "application/json"
      get :show, { id: ''}
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create order successfully' do
      request.accept = "application/json"
      order = FactoryGirl.create(:order)
      post :create, { order: { user_id: order.user_id, item_id: order.item_id, order_number: order.order_number, payment_mode: order.payment_mode } }
      response.should have_http_status(:ok)
    end

    it 'should create order unsuccessfully' do
      request.accept = "application/json"
      post :create, { order: { user_id: '', item_id: '', order_number: '', payment_mode: '' } }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST edit' do
    it 'should not create order with invalid user' do
      request.accept = 'application/json'
      order = FactoryGirl.create(:order)
      post :create, order: { user_id: 'qq', item_id: order.item_id, order_number: order.order_number, payment_mode: order.payment_mode }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create order with invalid item' do
      request.accept = 'application/json'
      order = FactoryGirl.create(:order)
      post :create, order: { user_id: order.user_id, item_id: 'ss', order_number: order.order_number, payment_mode: order.payment_mode }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST edit' do
    it 'should get correct order successfully' do
      request.accept = 'application/json'
      order = FactoryGirl.create(:order)
      get :edit, id: order.id
      assigns(:order).should eq order
      response.should have_http_status(:ok)
    end

    it 'should not get order with invalid id' do
      request.accept = 'application/json'
      get :edit, id: '12345'
      response.should have_http_status(:not_found)
    end
  end

  context 'PUT update' do
    it 'should update order successfully' do
      request.accept = "application/json"
      order = FactoryGirl.create(:order)
      put :update, { id: order.id, order: { user_id: order.user_id, item_id: order.item_id, order_number: order.order_number, payment_mode: order.payment_mode } }
      response.should have_http_status(:ok)
    end

    it 'should update order unsuccessfully' do
      request.accept = "application/json"
      order = FactoryGirl.create(:order)
      put :update, { id: order.id, order: { user_id: '', item_id: '', order_number: '', payment_mode: '' } }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT edit' do
    it 'should not update order with invalid user' do
      request.accept = 'application/json'
      order = FactoryGirl.create(:order)
      post :update, id: order.id, order: { user_id: 'dd', item_id: order.item_id, order_number: order.order_number, payment_mode: order.payment_mode }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update order with invalid item' do
      request.accept = 'application/json'
      order = FactoryGirl.create(:order)
      post :update, id: order.id, order: { user_id: order.user_id, item_id: 'dd', order_number: order.order_number, payment_mode: order.payment_mode }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete order successfully' do
      request.accept = "application/json"
      order = FactoryGirl.create(:order)
      delete :destroy, { id: order.id }
      response.should have_http_status(:ok)
    end

    it 'should delete order unsuccessfully' do
      request.accept = "application/json"
      delete :destroy, { id: ''}
      response.should have_http_status(:not_found)
    end
  end	
end