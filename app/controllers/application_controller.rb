class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  private
  def signed_in_user
    unless signed_in?
      # store_location
      redirect_to signin_path
    end
  end

end
