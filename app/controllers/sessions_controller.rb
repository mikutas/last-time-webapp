class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    if auth.blank?
      flash.now[:danger] = 'Authorization failed.'
      return redirect_to root_url
    end

    @auth = Authorization.find_by_auth(auth)
    if @auth
      @auth.user.update_email(email: auth['info']['email'])
    else
      @auth = Authorization.create_with_auth!(auth)
    end
    user = @auth.user
    log_in user
    redirect_back_or user_events_path(user.id)
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
