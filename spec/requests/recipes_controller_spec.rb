require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET #index' do
    context 'when user is signed in' do
      it 'renders the index template' do
        user = FactoryBot.create(:user)
        sign_in user
        get recipes_path
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to the sign-in page' do
        get recipes_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when user is signed in' do
      it 'renders the show template' do
        user = FactoryBot.create(:user)
        recipe = FactoryBot.create(:recipe, user:)
        sign_in user
        get recipe_path(recipe)
        expect(response).to render_template(:show)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to the sign-in page' do
        recipe = FactoryBot.create(:recipe)
        get recipe_path(recipe)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
