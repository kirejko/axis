require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  context 'logged user' do
    render_views

    before do
      sign_in build(:user)
      @users = create_list(:user, 5)
    end

    describe 'GET #index' do
      it 'return success response' do
        get :index
        expect(response).to have_http_status :success
        expect(response.body).to match @users.first.profile.full_name
      end
    end

    describe 'GET #show' do
      it 'should return success response' do
        user = @users.first

        get :show, params: { id: user.id }
        expect(response).to have_http_status :success
        expect(response.body).to match user.role
        p response.body
        expect(response.body).to match user.profile.full_name
      end
    end

  end

end
