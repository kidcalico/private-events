class UsersController < ApplicationController
  def show
    @attended_events = current_user.attended_events
    @hosted_events = current_user.hosted_events
  end
end
