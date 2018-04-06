require 'rails_helper'

RSpec.describe Admin::DepartmentsController, type: :controller do

  describe 'GET #new' do
    it 'return http success for admin users' do
      sign_in build(:admin)

      get :new
      expect(response).to have_http_status :success
    end

    it 'rise pundit exception for non-admin users' do
      bypass_rescue

      sign_in build(:user)
      expect { get :new }.to raise_error(ActionController::RoutingError)
      expect(response).to have_http_status :success
    end
  end

  describe 'POST #create' do
    it 'department create correctly' do
      sign_in build(:admin)

      post :create, params: { department: attributes_for(:department) }
      expect(response).to have_http_status :redirect
    end

    it 'rise pundit exception for non-admin users' do
      bypass_rescue

      sign_in build(:user)
      expect { post :create }.to raise_error(ActionController::RoutingError)
      expect(response).to have_http_status :success
    end
  end

  context 'with already created department' do
    before do
      @department = create(:department)
    end

    describe 'GET #edit' do
      it 'department edit correctly' do
        sign_in build(:admin)

        get :edit, params: {
          id:         @department.id,
          department: attributes_for(:department)
        }
        expect(response).to have_http_status :success
      end

      it 'rise pundit exception for non-admin users' do
        bypass_rescue
        sign_in build(:user)

        expect do
          get :edit, params: {
            id:         @department.id,
            department: attributes_for(:department)
          }
        end.to raise_error(ActionController::RoutingError)
        expect(response).to have_http_status :success
      end
    end

    describe 'PATCH #update' do
      it 'department update correctly' do
        sign_in build(:admin)

        patch :update, params: {
          id:         @department.id,
          department: attributes_for(:department)
        }
        expect(response).to have_http_status :redirect
      end

      it 'department update validation fail' do
        sign_in build(:admin)

        patch :update, params: {
          id:      @department.id,
          department: attributes_for(:invalid_department)
        }
        expect(response).to have_http_status :success
      end

      it 'rise pundit exception for non-admin users' do
        bypass_rescue
        sign_in build(:user)

        expect do
          patch :update, params: {
            id:         @department.id,
            department: attributes_for(:department)
          }
        end.to raise_error(ActionController::RoutingError)
        expect(response).to have_http_status :success
      end
    end

    describe 'DELETE #destroy' do
      it 'department delete successful' do
        sign_in build(:admin)

        patch :destroy, params: { id: @department.id }
        expect(response).to have_http_status :success
        expect(response.content_type).to eq "application/json"
      end
    end
  end

end
