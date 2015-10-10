class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  before_action :others_allowed_access?

  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
    @teacher.students.build
    @teacher.grades.build
  end

  # GET /teachers/1/edit
  def edit
    @teacher.students.build
    @teacher.grades.build

  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to @teacher, notice: 'Teacher was successfully created.'
    else
      render :new
    end
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to @teacher, notice: 'Teacher was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @teacher.destroy
    redirect_to teachers_url, notice: 'Teacher was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit( :name, :email, :password,
      student_attributes: [:name, :email, :password, :teacher_id],
      grade_attributes: [:student_id, :assignment_name, :grade])
    end


    def others_allowed_access?
       teacher_ids = Teacher.all.map {|p| p.id}
    unless (teacher_ids.include?(session[:user_id]) && session[:user_type] == "Teacher")
      redirect_to dashboard_index_path, notice: "access denied, Nice try."
    end
  end
end
