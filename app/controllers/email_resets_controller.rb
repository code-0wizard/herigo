class EmailResetsController < ApplicationController
  before_action :logged_in_user,   only: [:create, :new]

  def new
  end

  def create
    if params[:email_reset][:email].empty?
      flash.now[:danger] = "メールアドレスが入力されていません"
      render 'new', status: :unprocessable_entity
    else
      @user = User.find_by(email: params[:email_reset][:email])
      if @user.nil?
        current_user.create_email_reset_digest(params[:email_reset][:email])
        current_user.send_email_reset_email
        render 'mail_sent', status: :ok
      else
        flash.now[:danger] = "このメールアドレスは登録済みです"
        render 'new', status: :unprocessable_entity
      end
    end
  end

  def update
    @user = User.find_by(email: params[:old_email])
    redirect_to root_url unless (@user && @user.activated? && @user.authenticated?(:email_reset, params[:id])) #TODO
    if @user.email_reset_expired?
      render 'expired', status: :unprocessable_entity
    elsif @user.update(email_reset_params)
      reset_session
      log_in @user
      render 'reset_complete', status: :ok
    else
      render 'reset_failed', status: :unprocessable_entity
    end
  end

  private

  def email_reset_params
    params.require(:email_reset).permit(:email)
  end

end
