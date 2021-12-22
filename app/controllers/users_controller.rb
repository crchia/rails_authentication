class UsersController < ApplicationController
  before_action :require_user_logged_in!, only: [:update]

  # POST /signup
  # creates a new user
  def create
    # implement session based auth for now
    @user = User.new(user_params)

    # attempt to save the user to the db
    @user.save!
    session[:user_id] = @user.id
    json_response({success: true})

    rescue ActiveRecord::RecordInvalid => invalid
      json_response({success: false,
                     errors: invalid.record.errors})
    # rescue => err
    #   json_response({message: err.to_s})
  end

  # PUT /users/:user_id
  def update
    # attempt to update the user info
    Current.user.update!(user_params)
    json_response({success: true})

    # update failed, return error messages
    rescue ActiveRecord::RecordInvalid => invalid
      json_response({success: false,
                     errors: invalid.record.errors})
  end

  private
    def user_params
      params.permit(:username, :email, :password, :password_confirmation)
    end
end
