class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @all_recipes = @user.recipes
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
