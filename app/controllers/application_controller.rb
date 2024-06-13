class ApplicationController < ActionController::Base
  include SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        store_location
        render 'shared/login', status: :unprocessable_entity
      end
    end

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
end
