require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe 'GET #index' do
    it 'returns http success for auth user' do
      sign_in build(:user)

      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns http redirect for non-auth user' do
      get :index
      expect(response).to have_http_status(:redirect)
      assert_redirected_to '/login'
    end
  end

end
