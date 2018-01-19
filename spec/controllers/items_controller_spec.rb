require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  context 'GET index' do
    it 'should show all items' do
      request.accept = "application/json"
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new' do
    it 'should get new item successfully' do
      request.accept = "application/json"
      get :new
      assigns(:item).id.should eq nil
      assigns(:item).name.should eq nil
      assigns(:item).price.should eq nil
      assigns(:item).weight.should eq nil
      assigns(:item).brand.should eq nil
      assigns(:item).category_id.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show item successfully' do
      request.accept = "application/json"
      item = FactoryGirl.create(:item)
      get :show, { id: item.id }
      response.should have_http_status(:ok)
    end

    it 'should show item unsuccessfully' do
      request.accept = "application/json"
      get :show, { id: ''}
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create item successfully' do
      request.accept = "application/json"
      item = FactoryGirl.create(:item)
      post :create, { item: { category_id: item.category_id, name: item.name, price: item.price, weight: item.weight, brand: item.brand } }
      response.should have_http_status(:ok)
    end

    it 'should create item unsuccessfully' do
      request.accept = "application/json"
      post :create,  { item: { category_id: '', name: '', price: '', weight: '', brand: '' } }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create item with invalid category' do
      request.accept = 'application/json'
      item = FactoryGirl.create(:item)
      post :create, item: { category_id: 'qq', name: item.name, price: item.price, weight: item.weight, brand: item.brand  }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST edit' do
    it 'should get correct item successfully' do
      request.accept = 'application/json'
      item = FactoryGirl.create(:item)
      get :edit, id: item.id
      assigns(:item).should eq item
      response.should have_http_status(:ok)
    end

    it 'should not get item with invalid id' do
      request.accept = 'application/json'
      get :edit, id: '12345'
      response.should have_http_status(:not_found)
    end
  end

  context 'PUT update' do
    it 'should update item successfully' do
      request.accept = "application/json"
      item = FactoryGirl.create(:item)
      put :update, { id: item.id, item: { category_id: item.category_id, name: item.name, price: item.price, weight: item.weight, brand: item.brand  } }
      response.should have_http_status(:ok)
    end

    it 'should update item unsuccessfully' do
      request.accept = "application/json"
      item = FactoryGirl.create(:item)
      put :update, { id: item.id, item: { category_id: '', name: '', price: '', weight: '', brand: '' } }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT edit' do
    it 'should not update item with invalid category' do
      request.accept = 'application/json'
      item = FactoryGirl.create(:item)
      post :update, id: item.id, item: { category_id: 'ddd', name: item.name, price: item.price, weight: item.weight, brand: item.brand   }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete item successfully' do
      request.accept = "application/json"
      item = FactoryGirl.create(:item)
      delete :destroy, { id: item.id }
      response.should have_http_status(:ok)
    end

    it 'should delete item unsuccessfully' do
      request.accept = "application/json"
      delete :destroy, { id: ''}
      response.should have_http_status(:not_found)
    end
  end	
end