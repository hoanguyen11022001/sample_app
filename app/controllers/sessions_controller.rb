class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
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
