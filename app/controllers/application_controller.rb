class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      return if logged_in?

      store_location
      flash[:danger] = 'Please sign in.'
      redirect_to root_url
    end

    # 正しいユーザーかどうか確認
    def correct_user
      return if current_user?(@user)

      flash[:danger] = 'Wrong user.'
      redirect_to root_url
    end
end
