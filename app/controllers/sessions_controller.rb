class SessionsController < ApplicationController
  # require user to be logged in in order to logout
  before_action :require_user_logged_in!, only: [:show, :destroy]

  # GET /auth
  def show
    # get the current user
    json_response(Current.user)
  end

  # POST /auth
  # log in the user
  def create
    # find the current user by email
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      json_response({success: true})
    else
      json_response({success: false})
    end
  end

  # DELETE /auth
  def destroy
    # deletes user session
    session[:user_id] = nil
    json_response({message: 'Logged Out'})
  end
end
