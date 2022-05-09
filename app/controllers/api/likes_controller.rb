module Api
  class LikesController < ActionController::Base
    protect_from_forgery with: :null_session

    def create
      @tweet = Tweet.find(params[:tweet_id])
      @user = User.find(params[:user_id])
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