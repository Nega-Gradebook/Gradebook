class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  before_action :parent_and_student_allowed_access?, only: [:show]

  # GET /students
  def index
    @students = Student.all
  end

  # GET /students/1
  def show

  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice:  'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice:  'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit
      end
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice:  'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :email, :password, :teacher_id)
    end

    def parent_and_student_allowed_access?
      parent_ids = @student.parents.map {|p| p.id}
      unless (parent_ids.include?(session[:user_id]) && session[:user_type] == "Parent") || (session[:user_id] == @student.id && session[:user_type] == "Student") || (session[:user_id] == @student.teacher_id && session[:user_type] == "Teacher")
        redirect_to dashboard_index_path, notice:  "access denied, I need a parent!!."
      end
    end
end
