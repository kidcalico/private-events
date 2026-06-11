class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @invite = Invite.new
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.hosted_events.build(event_params)

    if @event.save
      redirect_to @event, notice: "Event successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  private

    def event_params
      params.expect(event: [ :party_title, :date, :location, :more_info ])
    end
end
