class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      unless @auth = Authorization.find_by_auth(auth)
        @auth = Authorization.create_with_auth(auth)
      end
      user = @auth.user
      log_in user
      redirect_back_or user
    else
      flash.now[:danger] = 'Authorization failed.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
