class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private def logged_in?
    redirect_to login_path, notice:  "access denied." unless session[:user_id]
  end

  private def logged_in_parent
    @parent = Parent.find_by(session[:parent_id])
  end

end
