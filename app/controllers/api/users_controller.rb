module Api
  class UsersController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :authorize_request, except: :create
    # before_action :find_user, except: %i[create index]

    def index
      render json: User.all
    end

    def show
      render json: User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ["User not found"] }, status: :not_found
    end

    def create
      @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
  
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      @user = User.find(params[:id])
      if @user.update(params.require(:user).permit(:name, :bio, :email))
        render json: @user
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ["User not found"] }, status: :not_found
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      render json: @user
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ["User not found"] }, status: :not_found
    end
  end
end