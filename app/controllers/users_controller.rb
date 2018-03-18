class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def show
    @user = User.find(params[:id])
    @events = @user.events.paginate(page: params[:page]).includes(:occurred_dates).order("occurred_dates.created_at DESC")
  end

  def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Your account is successfully deleted."
    redirect_to root_url
  end

  private

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
