class Api::V1::UsersController < ApplicationController
before_action :find_fact, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render error: { error: 'Unable to create User.'}, status: 400
    end
  end

  def update
    if @user
      @user.update(user_params)
      render json: { message: 'User succcessfully updated.'}, status: 200
    else
      render json: { error: 'User not found'}, status: 400
    end
  end

  def destroy
    if @user
      @user.destroy
      render json: { message: 'User succesfully deleted.'}, status: 200
    else
      render json: { error: 'User not found.'}, status: 400
    end
  end

  private

    def search
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end

end
