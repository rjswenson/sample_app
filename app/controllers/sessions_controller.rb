class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #sign in user and redirect to their user page
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end


end
