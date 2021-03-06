require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do

  describe 'GET #new' do
    it 'return http success for admin users' do
      sign_in build(:admin)

      get :new
      expect(response).to have_http_status :success
    end

    it 'rise exception for non-admin users' do
      bypass_rescue

      sign_in build(:user)
      expect { get :new }.to raise_error(ActionController::RoutingError)
      expect(response).to have_http_status :success
    end
  end

  describe 'POST #create' do
    it 'article create correctly' do
      sign_in build(:admin)

      post :create, params: { article: attributes_for(:article) }
      expect(response).to have_http_status :redirect
    end

    it 'article create validation fail' do
      sign_in build(:admin)

      post :create, params: { article: attributes_for(:invalid_article) }
      expect(response).to have_http_status :success
    end

    it 'rise pundit exception for non-admin users' do
      bypass_rescue

      sign_in build(:user)
      expect { post :create }.to raise_error(ActionController::RoutingError)
      expect(response).to have_http_status :success
    end
  end

  context 'with already created article' do
    before { @article = create(:article) }

    describe 'GET #edit' do
      it 'article edit correctly' do
        sign_in build(:top_manager)

        get :edit, params: {
          id:      @article.id,
          article: attributes_for(:article)
        }
        expect(response).to have_http_status :success
      end

      it 'rise pundit exception for non-admin users' do
        bypass_rescue
        sign_in build(:user)

        expect do
          get :edit, params: {
            id:      @article.id,
            article: attributes_for(:article)
          }
        end.to raise_error(ActionController::RoutingError)
        expect(response).to have_http_status :success
      end
    end

    describe 'PATCH #update' do
      it 'article update correctly' do
        sign_in build(:top_manager)

        patch :update, params: {
          id:      @article.id,
          article: attributes_for(:article)
        }
        expect(response).to have_http_status :redirect
      end

      it 'article update validation fail' do
        sign_in build(:top_manager)

        patch :update, params: {
          id:      @article.id,
          article: attributes_for(:invalid_article)
        }
        expect(response).to have_http_status :success
      end

      it 'rise pundit exception for non-admin users' do
        bypass_rescue
        sign_in build(:user)

        expect do
          patch :update, params: {
            id:      @article.id,
            article: attributes_for(:article)
          }
        end.to raise_error(ActionController::RoutingError)
        expect(response).to have_http_status :success
      end
    end

    describe 'DELETE #destroy' do
      it 'article delete successful' do
        sign_in build(:top_manager)

        patch :destroy, params: { id: @article.id }
        expect(response).to have_http_status :success
        expect(response.content_type).to eq "application/json"
      end
    end
  end

end
