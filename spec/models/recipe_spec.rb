require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'is valid with valid attributes' do
    user = FactoryBot.create(:user)
    recipe = FactoryBot.build(:recipe, user:)
    expect(recipe).to be_valid
  end

  it 'is not valid without a recipe name' do
    recipe = FactoryBot.build(:recipe, name: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without preparation time' do
    recipe = FactoryBot.build(:recipe, preparation_time: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without cooking time' do
    recipe = FactoryBot.build(:recipe, cooking_time: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a description' do
    recipe = FactoryBot.build(:recipe, description: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a user' do
    recipe_without_user = FactoryBot.build(:recipe, user: nil)
    expect(recipe_without_user).to_not be_valid
  end

  it 'is not valid with an invalid user_id' do
    recipe_with_invalid_user_id = FactoryBot.build(:recipe, user_id: 999)
    expect(recipe_with_invalid_user_id).to_not be_valid
  end

  it 'is valid with a valid user_id' do
    user = FactoryBot.create(:user)
    recipe = FactoryBot.build(:recipe, user:)
    expect(recipe).to be_valid
  end
end
