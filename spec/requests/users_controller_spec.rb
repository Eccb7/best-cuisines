require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'renders the index template when the user is signed in' do
      user = FactoryBot.create(:user)
      sign_in user

      get recipes_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        name: 'Ojwang Briton',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }
    end

    it 'creates a new user with valid parameters' do
      expect do
        post user_registration_path, params: { user: valid_params }

        expect(response).to have_http_status(:redirect)
      end.to change(User, :count).by(1)
    end
  end
end
