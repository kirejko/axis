require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do

  describe 'GET #new' do
    it 'return http success for admin users' do
      sign_in build(:admin)

      get :new
      expect(response).to have_http_status :success
    end

    it 'rise pundit exception for non-admin users' do
      bypass_rescue

      sign_in build(:user)
      expect { get :new }.to raise_error(Pundit::NotAuthorizedError)
      expect(response).to have_http_status :success
    end
  end

  describe 'POST #create' do
    it 'article create correctly' do
      sign_in build(:admin)

      post :create, make
    end

    it 'rise pundit exception for non-admin users' do
      bypass_rescue

      sign_in build(:user)
      expect { post :create }.to raise_error(Pundit::NotAuthorizedError)
      expect(response).to have_http_status :success
    end
  end

end
