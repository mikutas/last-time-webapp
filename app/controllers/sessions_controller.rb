class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      unless @auth = Authorization.find_by_auth(auth)
        @auth = Authorization.create_with_auth(auth)
      else
        @auth.user.update_attributes(email: auth['info']['email']) if @auth.user.email.casecmp(auth['info']['email']) != 0
      end
      user = @auth.user
      log_in user
          redirect_to user_events_path(user.id)
    else
      flash.now[:danger] = 'Authorization failed.'
      redirect_to root_url
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
