class ApplicationController < ActionController::API
  include Response

  before_action :set_current_user

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user_logged_in!
    # allows only logged in user
    if Current.user.nil?
      json_response({message: 'You must be logged in!'}, status=:unauthorized)
    end
  end
end
