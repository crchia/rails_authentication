class PasswordsController < ApplicationController
  # require user to be logged in in order to logout
  before_action :require_user_logged_in!

  def update
    # make sure the current password is correct
    if Current.user.authenticate(password_params[:current])
      # construct new object to be passed to update!
      new_pass = {password: password_params[:new], password_confirmation: password_params[:new_confirm]}
      Current.user.update!(new_pass)
      # successful password update
      json_response({success: true})
    else
      # current password incorrect
      json_response({success: false, message: 'Current password incorrent!'})
    end

    # missing a parameter or invalid parameter
    rescue ActionController::ParameterMissing => error
      json_response({success: false, error: error})

    # update failed, return error messages
    rescue ActiveRecord::RecordInvalid => invalid
      json_response({success: false,
                     errors: invalid.record.errors})
  end

  private
    def password_params
      params.require([:current, :new, :new_confirm])
      params.permit(:current, :new, :new_confirm)
    end


end
