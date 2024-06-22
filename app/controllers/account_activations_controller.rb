class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      render 'success', status: :ok
    else
      render 'failed', status: :unprocessable_entity
    end
  end
end
