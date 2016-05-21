class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                      :followings, :followers]

  def show # 追加
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     flash[:success] = "Welcome to the Sample App!"
     redirect_to @user # ここを修正
    else
     render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:success] = "Updated your Plofile"
     redirect_to @user
    else
     render 'edit'
    end
  end

  def followings
    @title = "Followings"
    @user  = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follow'
  end

  private

  def user_params
   params.require(:user).permit(:name, :email, :location, :password,
                                :password_confirmation)
  end

  def collect_user
   @user = User.find(params[:id])
   redirect_to root_path if @user != current_user
  end
end
