class SessionsController < ApplicationController
  def new
    if signed_in?
      redirect_to root_path 
    else
      # render 'new', layout: "sign"
      render 'new'
    end
  end

  def create
    user = User.find_by_name(params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      # redirect_back_or root_path
      respond_to do |format|
        format.js { render js: 'location.href="/"'}
      end 

    else
      # flash.now[:error] = 'Invalid name/password combination'
      # render 'new'
      respond_to do |format|
        format.js { render js: 'alert_error();'}
      end 

    end
  end
  def destroy
    sign_out
    redirect_to root_path
  end
end
