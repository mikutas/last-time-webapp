class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'Your account is successfully deleted.'
    redirect_to root_url
  end

  private

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = 'Wrong user.'
        redirect_to root_url
      end
    end
end
