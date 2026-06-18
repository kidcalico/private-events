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

  private

    def event_params
      params.expect(event: [ :party_title, :date, :location, :more_info, :visibility, :attendee_ids ])
    end
end
