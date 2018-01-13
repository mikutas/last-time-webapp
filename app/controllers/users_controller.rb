class UsersController < ApplicationController
  before_action :logged_in_user

  def show
    @user = User.find(params[:id])
  end

  private

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
