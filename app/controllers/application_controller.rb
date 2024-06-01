class ApplicationController < ActionController::Base
  include SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url, status: :see_other
      end
    end

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
