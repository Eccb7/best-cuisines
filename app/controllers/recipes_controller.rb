class RecipesController < ApplicationController
  include RecipesHelper

  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show destroy toggle_public add_food create_food]

  def index
    @user_recipes = current_user.recipes
    @public_recipes = Recipe.public_recipes.order(created_at: :desc)
    @recipes = (@user_recipes + @public_recipes).uniq

    @owned_recipes = @recipes.select { |recipe| current_user_owns_recipe?(recipe) }
  end

  def show
    if @recipe.visible_to?(current_user) || current_user_owns_recipe?(@recipe)
      @recipe_foods = @recipe.recipe_foods.includes(:food)
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('recipes', partial: 'recipe',
                                                              locals: { recipe: @recipe,
                                                                        current_user_owns_recipe: method(:current_user_owns_recipe?) })
        end
      end
    else
      render :new
    end
  end

  def destroy
    redirect_to root_path, alert: 'Access denied.' unless current_user_owns_recipe?(@recipe)

    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully destroyed.'
  end

  def public_recipes
    @public_recipes = Recipe.public_recipes.order(created_at: :desc)
  end

  def toggle_public
    redirect_to root_path, alert: 'Access denied.' unless current_user_owns_recipe?(@recipe)

    @recipe.toggle_visibility
    redirect_to @recipe, notice: 'Recipe privacy status updated.'
  end

  def add_food
    redirect_to root_path, alert: 'Access denied.' unless current_user_owns_recipe?(@recipe)

    @food = Food.new
  end

  def create_food
    redirect_to root_path, alert: 'Access denied.' unless current_user_owns_recipe?(@recipe)

    @food = Food.new(food_params)
    @food.user = current_user

    if @food.save
      @recipe.foods << @food
      redirect_to @recipe, notice: 'Food added successfully.'
    else
      render :add_food
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def current_user_owns_recipe?(recipe)
    recipe.user == current_user
  end
end
