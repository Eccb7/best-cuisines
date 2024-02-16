class RecipeFoodsController < ApplicationController
  before_action :set_recipe

  def new
    @recipe_food = @recipe.recipe_foods.build
    @recipe_food.build_food
  end

  def create
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
    if @recipe_food.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, food_attributes: [:name, :quantity, :price])
  end
end
