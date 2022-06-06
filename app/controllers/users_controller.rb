class UsersController < ApplicationController
  before_action :require_user_logged_in!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = Current.user
  end

  def edit
  end

  def update
    if Current.user.update(params.require(:user).permit(:email, :bio))
      redirect_to @user
    else
      render 'edit'
    end
  end
end