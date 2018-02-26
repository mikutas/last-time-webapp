class OccurredDatesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: :destroy

  def create
    @event = current_user.events.find_by_id(params[:occurred_date][:event_id])
    @occurred_date = @event.occurred_dates.build(occurred_date_params)
    if @occurred_date.save
      flash[:success] = 'Event updated.'
    else
      flash[:danger] = 'Event update failed.'
    end
    redirect_to event_path(@event.id)
  end

  def destroy
    eid = @occurred_date.event_id
    @occurred_date.destroy
    redirect_to event_path(eid)
  end

  private

    def occurred_date_params
      params.require(:occurred_date).permit(:created_at)
    end

    def correct_user
      @occurred_date = OccurredDate.find_by_id(params[:id])
      redirect_to root_url unless @occurred_date.event.user == current_user
    end
end
