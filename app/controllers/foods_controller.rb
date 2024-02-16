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
      puts 'Food added successfully.' # Check your console for this message
      redirect_to foods_path, notice: 'Food added successfully.'
    else
      puts 'Failed to save food.' # Check your console for this message
      render :new
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
