class InvitesController < ApplicationController
  def create
    @invite = current_user.invites.build(attended_event_id: params[:invite][:attended_event_id], rsvp: params[:invite][:rsvp])
    if @invite.save
      redirect_to root_path, notice: "Thanks for responding!"
    else
      redirect_to root_path, alert: "Something went wrong."
    end
  end

  def destroy
  end
end
