class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user id inside the browser cookie.
      session[:user_id] = @user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      @login_fail = 'Oops, something went wrong. Please check your login info and try again.'
      render '/sessions/new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
