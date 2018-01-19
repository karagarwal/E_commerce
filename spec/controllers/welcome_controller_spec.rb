require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  context 'GET #index' do
    it 'should show welcome page successfully' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end