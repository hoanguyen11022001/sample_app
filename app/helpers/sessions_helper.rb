module SessionsHelper
  def log_in user
    # saves user id to client's session cookie
    session[:user_id] = user.id
  end

  def current_user
    # gets current user info
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    # shorthand for checking if current user is present
    current_user.present?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
