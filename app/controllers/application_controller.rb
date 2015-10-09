class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private def logged_in?
    redirect_to login_path, notice: "You've been redirected" unless session[:logged_in_teacher] || session[:logged_in_student] || session[:logged_in_parent]
  end
end
