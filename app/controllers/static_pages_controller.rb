class StaticPagesController < ApplicationController
  def home
    redirect_to user_events_path(current_user.id) if logged_in?
  end

  def help
  end

  def about
  end
end
