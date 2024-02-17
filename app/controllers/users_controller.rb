class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show
    if @user
      @recipes = @user.recipes
    else
      # Handle the case where params[:id] is "sign_out"
      redirect_to root_path, notice: 'User not found'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def sign_out_user
    if params[:id] == 'sign_out'
      # Handle sign out without fetching a user from the database
      redirect_to root_path, notice: 'Signed out successfully'
    else
      sign_out(current_user)
      redirect_to root_path, notice: 'Signed out successfully'
    end
  end

  private

  def set_user
    @user = params[:id] == 'sign_out' ? nil : User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
