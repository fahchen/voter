class UsersController < ApplicationController
  def new
    if signed_in?
      redirect_to root_path 
    else
      @user = User.new
      render layout: "sign"
    end
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		flash[:success] = 'sign up succeed'
      sign_in @user
  		# redirect_to root_path
      respond_to do |format|
        format.js {render js: 'history.go(0);'}
      end
  	else
  		# render 'new'
      respond_to do |format|
        format.js {render js: '$("#signup_error").fadeIn();'}
      end

  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to root_path
  	else
  		render 'edit'
  	end
  end
end
