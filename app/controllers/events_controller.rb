class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:show, :destroy]
  before_action :already_exists?, only: :create

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
  end

  def update
  end

  private

    def event_params
      params.require(:event).permit(:title, :created_at)
    end

    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      if @event.nil?
        flash[:danger] = "Event not found."
        redirect_to current_user
      end
    end

    def already_exists?
      if current_user.events.exists?(title: params[:event][:title])
        flash[:danger] = "The event already exists."
        redirect_to current_user
      end
    end
end
