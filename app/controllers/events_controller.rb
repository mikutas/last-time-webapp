class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:show, :edit, :update, :destroy]

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created!"
      redirect_to current_user
    else
      flash[:danger] = "Failed to create event."
      redirect_to current_user
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Event deleted."
    redirect_to current_user
  end

  def show
    @occurred_dates = @event.occurred_dates.paginate(page: params[:page])
  end

  def edit
    respond_to do |format|
      format.html{
        @occurred_dates = @event.occurred_dates.paginate(page: params[:page])
      }
      format.js
    end
  end

  def update
    flash[:danger] = 'Failed to update event.' unless @event.update_attributes(title: params[:title])
    redirect_to @event
  end

  private

    def event_params
      params.require(:event).permit(:title, :first_occurred_at)
    end

    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      if @event.nil?
        flash[:danger] = "Event not found."
        redirect_to current_user
      end
    end
end
