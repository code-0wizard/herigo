class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
    @feeds = current_user.feed.paginate(page: params[:page]) if logged_in?
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @like_reviews = @user.like_reviews
  end
  
  def create
    @user = User.new(user_params)
    default_icon_path = Rails.root.join("app/assets/images/default_icon.png")
    @user.profile_image.attach(io: File.open(default_icon_path), filename: 'default_icon.png', content_type: 'image/png')
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url, status: :see_other
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :profile_image, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

end
