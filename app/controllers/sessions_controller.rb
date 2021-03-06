class SessionsController < ApplicationController

  def create
    if request.post?
      teacher = Teacher.find_by_email(params[:email])
      parent = Parent.find_by_email(params[:email])
      student = Student.find_by_email(params[:email])
      if teacher && teacher.authenticate(params[:password])
        session[:user_type] = "Teacher"
        session[:user_id] = teacher.id
        redirect_to teacher_path(teacher.id), notice:  "You successfully logged in."
      elsif student && student.authenticate(params[:password])
        session[:user_type] = "Student"
        session[:user_id] = student.id
        redirect_to student_path(student.id), notice:  "You successfully logged in."
      elsif parent && parent.authenticate(params[:password])
        session[:user_type] = "Parent"
        session[:user_id] = parent.id
        redirect_to student_path(parent.student), notice:  "You successfully logged in."
      else
        redirect_to new_session_path, notice:  "Incorrect email/password."
      end
    end
  end

  def new
  end


  def destroy
    session[:user_type] = false
    session[:user_id] = false
    redirect_to login_path, alert: "you have successfully logged out."
  end

  def set_params
    params.require(:teacher_id).permit(:email, :password)
  end
end
