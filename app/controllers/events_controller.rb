class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: :destroy

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created!"
      redirect_to current_user
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Event deleted"
    redirect_to current_user
  end

  def show
    @user = User.find(params[:id])
    @event = @user.events.find(params[:eid])
    @occurred_dates = @event.occurred_dates.paginate(page: params[:page])
  end

  private

    def event_params
      params.require(:event).permit(:title)
    end

    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
end
