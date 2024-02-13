class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @new_food = Food.new
  end

  def create; end

  def destroy; end
end
