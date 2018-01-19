class EventsController < ApplicationController
  before_action :logged_in_user

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
    @event = current_user.events.find_by_id(params[:eid])
    @event.destroy
    flash[:success] = "Event deleted"
    redirect_to current_user
  end

  def show
    @user = User.find(params[:id])
    @event = Event.find(params[:eid])
    @occurred_dates = @event.occurred_dates.paginate(page: params[:page])
  end

  private

    def event_params
      params.require(:event).permit(:title)
    end
end
