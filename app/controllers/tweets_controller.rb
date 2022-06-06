class TweetsController < ApplicationController
  before_action :require_user_logged_in!

  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(params.require(:tweet).permit(:content).merge(user_id: Current.user.id))
    if @tweet.save
      redirect_to tweets_path, notice: "Tweet successfully created!"
    else
      render :new
    end
  end
end