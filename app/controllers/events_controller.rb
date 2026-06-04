class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to show_events_path, notice: "Event successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  private

    def event_params
      params.expect(event: [ :party_title, :date, :location, :more_info ])
    end
end
