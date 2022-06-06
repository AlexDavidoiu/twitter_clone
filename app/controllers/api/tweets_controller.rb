module Api
  class TweetsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :authorize_request, except: :create
    # before_action :find_user, except: %i[create index]

    def index
      render json: Tweet.all
    end

    def show
      render json: Tweet.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ["Tweet not found"] }, status: :not_found
    end

    def create
      @tweet = Tweet.new(params.require(:tweet).permit(:content, :user_id))

      if @tweet.save
        render json: @tweet, status: :created
      else
        render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      @tweet = Tweet.find(params[:id])
      if @tweet.update(params.require(:tweet).permit(:content))
        render json: @tweet
      else
        render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ["Tweet not found"] }, status: :not_found
    end

    def destroy
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
      render json: @tweet
    rescue ActiveRecord::RecordNotFound
      render json: {errors: ["Tweet not found"] }, status: :not_found
    end
  end
end