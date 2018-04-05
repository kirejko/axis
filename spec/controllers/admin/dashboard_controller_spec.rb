require 'rails_helper'

RSpec.describe ::Admin::DashboardController, type: :controller do

  describe "GET #index" do
    it "returns http redirect if non-auth" do
      get :index
      expect(response).to have_http_status(:redirect)
    end

    context "with render views" do
      render_views

      it "returns http not found if non-admin user" do
        sign_in build(:user)

        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to match '404 - Not Found'
      end
    end

    it "returns http success for admins" do
      sign_in build(:admin)

      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
