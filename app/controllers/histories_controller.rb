class HistoriesController < ApplicationController
  before_action :logged_in_user, :correct_user, :set_event
  before_action :set_history, only: [:destroy]

  def index
    @histories = @event.histories.paginate(page: params[:page])
  end

  def create
    @history = @event.histories.build(history_params)
    if @history.save
      flash[:success] = 'Event updated.'
    else
      flash[:danger] = 'Event update failed.'
    end
    redirect_to user_event_histories_path(@event.user.id, @event.id)
  end

  def destroy
    eid = @history.event_id
    if @history.event.histories.size == 1
      flash[:danger] = 'Cannot delete last one date.'
    else
      flash[:success] = 'Date deleted.'
      @history.destroy
    end
    redirect_to user_event_histories_path(@user.id, eid)
  end

  private

    def history_params
      params.require(:history).permit(:occurred_at)
    end

    def set_event
      @event = @user.events.find(params[:event_id])
    end

    def set_history
      @history = @event.histories.find(params[:id])
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:user_id])
      unless current_user?(@user)
        flash[:danger] = 'Wrong user.'
        redirect_to root_url
      end
    end
end
