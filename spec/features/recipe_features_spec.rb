require 'rails_helper'

RSpec.feature 'Recipe Features', type: :feature do
  scenario 'User creates a new recipe' do
    user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit new_recipe_path

    # fill_in 'name', with: 'New Recipe'
    fill_in 'recipe_preparation_time', with: '30'
    fill_in 'recipe_cooking_time', with: '45'
    fill_in 'recipe_description', with: 'A delicious recipe description.'
    check 'recipe_public'
    click_button 'Create Recipe'

    # expect(page).to have_content('Recipe was successfully created.')
    expect(page).to have_content('New Recipe')
  end
end
