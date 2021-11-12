class SessionsController < ApplicationController
  def new; end

  def create
    session_params = params[:session]
    user = User.find_by email: session_params[:email].downcase
    if user&.authenticate(session_params[:password])
      log_in user, session_params[:remember_me]
      flash[:success] = t "welcome_logged_in_message_html", username: user.name
      redirect_to user
    else
      flash.now[:danger] = t "email_or_password_incorrect"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
