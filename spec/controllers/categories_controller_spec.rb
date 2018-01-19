require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  context 'GET index' do
    it 'should show all categories successfully' do
      request.accept = "application/json"
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new' do
    it 'should get new category successfully' do
      request.accept = "application/json"
      get :new
      assigns(:category).id.should eq nil
      assigns(:category).name.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show category successfully' do
      request.accept = "application/json"
      category = FactoryGirl.create(:category)
      get :show, { id: category.id }
      response.should have_http_status(:ok)
    end

    it 'should show category unsuccessfully' do
      request.accept = "application/json"
      get :show, { id: ''}
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create category successfully' do
      request.accept = "application/json"
      category = FactoryGirl.create(:category)
      post :create, { category: { name: category.name } }
      response.should have_http_status(:ok)
    end

    it 'should create category unsuccessfully' do
      request.accept = "application/json"
      post :create, { category: { name: ''} } 
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST edit' do
    it 'should get correct category successfully' do
      request.accept = 'application/json'
      category = FactoryGirl.create(:category)
      get :edit, id: category.id
      assigns(:category).should eq category
      response.should have_http_status(:ok)
    end

    it 'should not get category with invalid id' do
      request.accept = 'application/json'
      get :edit, id: '12345'
      response.should have_http_status(:not_found)
    end
  end

  context 'PUT update' do
    it 'should update category successfully' do
      request.accept = "application/json"
      category = FactoryGirl.create(:category)
      put :update, { id: category.id, category: { name: category.name } }
      response.should have_http_status(:ok)
    end

    it 'should update category unsuccessfully' do
      request.accept = "application/json"
      category = FactoryGirl.create(:category)
      put :update,  { id: category.id, category: { name: '' } }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete category successfully' do
      request.accept = "application/json"
      category = FactoryGirl.create(:category)
      delete :destroy, { id: category.id }
      response.should have_http_status(:ok)
    end

    it 'should delete category unsuccessfully' do
      request.accept = "application/json"
      delete :destroy, { id: ''}
      response.should have_http_status(:not_found)
    end
  end	
end