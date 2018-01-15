class EventsController < ApplicationController

  def create
  end

  def edit
  end

  def update
  end

  def show
    @user = User.find(params[:id])
    @event = Event.find(params[:eid])
    @occurred_dates = @event.occurred_dates.paginate(page: params[:page])
  end
end
