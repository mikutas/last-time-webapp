class EventsController < ApplicationController
  before_action :logged_in_user, :correct_user
  before_action :set_event, only: [:destroy, :edit, :update]

  def index
    @events = @user.events.paginate(page: params[:page]).order('occurred_at DESC')
    if params[:event]
      @events = @events.search(params[:event][:term])
    end
  end

  def create
    @event = @user.events.build(event_params)
    if @event.save
      flash[:success] = 'Event created!'
    else
      flash[:danger] = 'Failed to create event.'
    end
    redirect_to user_events_path(@user.id)
  end

  def destroy
    @event.destroy
    flash[:success] = 'Event deleted.'
    redirect_to user_events_path(@user.id)
  end

  def edit
    respond_to do |format|
      format.html{
        @histories = @event.histories.paginate(page: params[:page])
      }
      format.js
    end
  end

  def update
    flash[:danger] = 'Failed to update event.' unless @event.update_attributes(event_params)
    redirect_to user_event_histories_path(@event.user.id, @event.id)
  end

  private

    def event_params
      params.require(:event).permit(:title, :occurred_at, :term)
    end

    def set_event
      @event = @user.events.find(params[:id])
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
