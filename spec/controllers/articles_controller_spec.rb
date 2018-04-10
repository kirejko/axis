require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  context 'logged user' do
    render_views

    before do
      sign_in build(:user)
      @articles = create_list(:article, 5)
    end

    describe 'GET #index' do
      it 'return success response' do
        get :index
        expect(response).to have_http_status :success
        expect(response.body).to match @articles.first.title
      end
    end

    describe 'GET #show' do
      it 'should return success response' do
        article = @articles.first

        get :show, params: { id: article.id }
        expect(response).to have_http_status :success
        expect(response.body).to match article.title
      end
    end

  end
end
