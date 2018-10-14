class UsersController < ApplicationController
  before_action :logged_in_user, :set_user, :correct_user

  def edit; end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'Your account is successfully deleted.'
    redirect_to root_url
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
