class SessionsController < ApplicationController

  def create
    if request.post?
      teacher = Teacher.find_by_email(params[:email])
      parent = Parent.find_by_email(params[:email])
      student = Student.find_by_email(params[:email])
      if teacher && teacher.authenticate(params[:password])
        session[:logged_in_teacher] = teacher.id
        redirect_to teachers_path, notice: "You successfully logged in."
      elsif student && student.authenticate(params[:password])
        session[:logged_in_student] = student.id
        redirect_to students_path(student.id), notice: "You successfully logged in."
      elsif parent && parent.authenticate(params[:password])
        session[:logged_in_parent] = parent.id
        redirect_to students_path(parent.student_id), notice: "You successfully logged in."
      else
        redirect_to login_path, notice: "Your login was not successful."
      end
    end
  end

  def new
  end


  def destroy
    session[:logged_in_teacher] = false
    session[:logged_in_student] = false
    session[:logged_in_parent] = false
    redirect_to login_path, alert: "you have successfully logged out."
  end

  def set_params
    params.require(:teacher_id).permit(:email, :password)
  end
end
