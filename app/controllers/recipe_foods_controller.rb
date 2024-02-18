class RecipeFoodsController < ApplicationController
  before_action :set_recipe

  def new
    @recipe_food = @recipe.recipe_foods.build
    @recipe_food.build_food
  end

  def create
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
    if @recipe_food.save
      respond_to(&:turbo_stream)
    else
      render :new
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Recipe not found.'
  end

  def recipe_food_params
    params.require(:recipe_food).permit(food_attributes: %i[name quantity price])
  end
end
