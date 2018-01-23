class OccurredDatesController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by_id(params[:id])
    redirect_to root_url if @user.nil?
    @event = @user.events.find_by_id(params[:eid])
    redirect_to root_url if @event.nil?
    @occurred_date = @event.occurred_dates.build(created_at: Time.zone.now)
    if @occurred_date.save
      flash[:success] = 'Event updated'
    else
      flash[:danger] = 'Event update failed'
    end
    redirect_to current_user
  end

  def destroy
    @occurred_date = OccurredDate.find_by_id(params[:id])
    redirect_to root_url if @occurred_date.nil?
    eid = @occurred_date.event_id
    @event = Event.find_by_id(eid)
    uid = User.find_by_id(@event.user_id)
    @occurred_date.destroy
    redirect_to show_event_path(uid, eid)
  end
end
