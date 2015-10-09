class SessionsController < ApplicationController

  def create
    if request.post?
      teacher = Teacher.find_by_email(params[:email])
      parent = Parent.find_by_email(params[:email])
      student = Student.find_by_email(params[:email])
      if teacher && teacher.authenticate(params[:password])
        session[:user_type] = "Teacher"
        session[:user_id] = teacher.id
        redirect_to teacher_path(teacher.id), notice: "You successfully logged in."
      elsif student && student.authenticate(params[:password])
        session[:user_type] = "Student"
        session[:user_id] = student.id
        redirect_to student_path(student.id), notice: "You successfully logged in."
      elsif parent && parent.authenticate(params[:password])
        session[:user_type] = "Parent"
<<<<<<< HEAD
        session[:user_id] = parent.student_id
        redirect_to student_path(parent.student_id), notice: "You successfully logged in."
=======
        session[:user_id] = parent.id
        redirect_to student_path(parent.student), notice: "You successfully logged in."
>>>>>>> 22984792aa2d59ce6c1fb3003022b26fe99378df
      else
        redirect_to login_path, notice: "Your login was not successful."
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
