require 'rails_helper'

RSpec.describe Admin::DepartmentsController, type: :controller do

  describe "GET #index" do
    it "returns http success for admin" do
      sign_in build(:admin)

      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      sign_in build(:admin)

      get :new
      expect(response).to have_http_status(:success)
    end

    it 'rise pundit exception for non-admin users' do
      bypass_rescue

      sign_in build(:user)
      expect { get :new }.to raise_error(Pundit::NotAuthorizedError)
      expect(response).to have_http_status :success
    end
  end

  describe "GET #create" do
    it "returns http success" do
      sign_in build(:admin)

      get :create
      expect(response).to have_http_status(:success)
    end

    it 'rise pundit exception for non-admin users' do
      bypass_rescue

      sign_in build(:user)
      expect { get :create }.to raise_error(Pundit::NotAuthorizedError)
      expect(response).to have_http_status :success
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
