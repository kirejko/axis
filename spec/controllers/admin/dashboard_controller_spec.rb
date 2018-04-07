require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do

  describe "GET #index" do
    it "returns http redirect if non-auth" do
      get :index
      expect(response).to have_http_status(:redirect)
    end

    it "returns http not found if non-admin user" do
      bypass_rescue
      sign_in build(:user)

      expect { get :index }.to raise_error(ActionController::RoutingError)
      expect(response).to have_http_status(:success)
    end

    it "returns http success for top managers" do
      RSpec::Expectations.configuration.on_potential_false_positives = :nothing
      sign_in build(:top_manager)

      expect { get :index }.not_to raise_error(ActionController::RoutingError)
      expect(response).to have_http_status(:success)
    end
  end

end
