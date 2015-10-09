class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private def logged_in?
<<<<<<< HEAD
    redirect_to login_path, notice: "You've been redirected" unless session[:user_id]
=======
    redirect_to login_path, notice: "access denied." unless session[:user_id]
>>>>>>> 22984792aa2d59ce6c1fb3003022b26fe99378df
  end

  private def logged_in_parent
    @parent = Parent.find_by(session[:parent_id])
  end

end
