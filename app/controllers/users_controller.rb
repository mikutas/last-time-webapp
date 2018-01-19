class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def show
    @user = User.find(params[:id])
    @events = @user.events.paginate(page: params[:page])
  end

  private

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
