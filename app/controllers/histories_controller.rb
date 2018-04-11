class HistoriesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: :destroy

  def create
    @event = current_user.events.find_by_id(params[:history][:event_id])
    @history = @event.histories.build(history_params)
    if @history.save
      flash[:success] = 'Event updated.'
    else
      flash[:danger] = 'Event update failed.'
    end
    redirect_to event_path(@event.id)
  end

  def destroy
    eid = @history.event_id
    if @history.event.histories.size == 1
      flash[:danger] = 'Cannot delete last one date.'
    else
      flash[:success] = 'Date deleted.'
      @history.destroy
    end
    redirect_to event_path(eid)
  end

  private

    def history_params
      params.require(:history).permit(:occurred_at)
    end

    def correct_user
      @history = History.find_by_id(params[:id])
      redirect_to root_url unless @history.event.user == current_user
    end
end
