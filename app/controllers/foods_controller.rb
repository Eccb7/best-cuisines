class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food added successfully.'
    else
      puts 'Failed to save food.'
      render :new
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.recipe_foods.destroy_all
    if @food.destroy
      redirect_to foods_path, notice: 'Food deleted successfully.'
    else
      redirect_to foods_path, alert: 'Couldn\'t remove the food item!'
    end
  end


  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
