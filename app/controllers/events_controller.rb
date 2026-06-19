class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  def index
    # @events = Event.all
    @past_events = Event.includes(:attendees, :host).past
    @upcoming_events = Event.includes(:attendees, :host).upcoming
  end

  def show
    @event = Event.find(params[:id])
    @invite = Invite.new
  end

  def new
    @event = Event.new
    @users = User.all
  end

  def create
    @event = current_user.hosted_events.build(event_params)

    if @event.save
      params[:event][:attendee_ids].reject(&:blank?).each do |user_id|
        invite = Invite.new(attended_event_id: @event.id, attendee_id: user_id)
        invite.save
      end
      redirect_to @event, notice: "Event successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @event = Event.find(params[:id])
    @users = User.all
    unless @event.host == current_user
      redirect_to @event, alert: "You cannot edit this event, try one of your own."
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.host == current_user
      if @event.update(event_params)
        redirect_to @event, notice: "Your event details have been updated."
      else
        render :edit, status: :unprocessable_content
      end
    else
      redirect_to @event, alert: "You cannot edit this event, try one of your own."
    end
  end

  private

    def event_params
      params.expect(event: [ :party_title, :date, :location, :more_info, :visibility, :attendee_ids ])
    end
end
