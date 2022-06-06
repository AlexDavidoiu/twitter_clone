module Api
  class LikesController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :authorize_request

    def create
      @tweet = Tweet.find(params[:tweet_id])
      @user = @current_user
      @like = Like.new(user: @user, tweet: @tweet)
      if @like.save
        render json: @like, status: :created
      else
        render json: { errors: @like.errors.full_messages }
      end
    end

    def destroy
      @tweet = Tweet.find(params[:tweet_id])
    end
  end
end