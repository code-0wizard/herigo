class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    if params[:password_reset][:email].empty?
      flash.now[:danger] = "メールアドレスが入力されていません"
      render 'new', status: :unprocessable_entity
    else
      @user = User.find_by(email: params[:password_reset][:email])
      if @user
        @user.create_reset_digest
        @user.send_password_reset_email
        flash[:info] = "パスワード再登録のメールを送信しました"
        redirect_to root_url
      else
        flash.now[:danger] = "このメールアドレスは登録されていません"
        render 'new', status: :unprocessable_entity
      end
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "パスワードが入力されていません")
      render 'edit', status: :unprocessable_entity
    elsif @user.update(user_params)
      reset_session
      log_in @user
      flash[:success] = "パスワードがリセットされました"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # beforeフィルタ

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # 有効なユーザーかどうか確認する
  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認する
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end
end
