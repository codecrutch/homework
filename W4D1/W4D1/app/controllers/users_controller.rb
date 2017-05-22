class UsersController < ApplicationController

  def index
    all_users = User.all
    render json: all_users
  end

  def create
    puts params[:user]
    render json: params
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    show
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: 423
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    index
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
