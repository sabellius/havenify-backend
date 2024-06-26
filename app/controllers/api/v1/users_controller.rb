class Api::V1::UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: UserSerializer.new(user).serializable_hash.to_json, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user).serializable_hash.to_json, status: :created
    else
      render_record_invalid(user)
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: UserSerializer.new(user).serializable_hash.to_json, status: :ok
    else
      render_record_invalid(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end

  def render_record_invalid(user)
    render json: { error: user.errors }, status: :unprocessable_entity
  end
end
