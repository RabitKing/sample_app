class SessionsController < ApplicationController
  def new
  end
  
  def create 
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      #log the user in and redirect to show
      log_in user
      if params[:session][:remember_me] == "1"
        remember user 
      end
      redirect_to user
    else
    flash.now[:danger] = "Invalid email/ password combination"  
    render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
