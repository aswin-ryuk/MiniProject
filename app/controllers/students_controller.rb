class StudentsController < ApplicationController

#load_and_authorize_resource

  before_action :set_student, only: [:courses_popup, :edit, :update]

  def index
    @students = Student.all.paginate :per_page => PER_PAGE, :page => params[:page]
    refresh_table
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:notice] = 'Student was successfully created.' 
      redirect_to students_path
    else
       render :new
    end
  end

  def update
    if @student.update(student_params)
      flash[:notice] = 'Student was successfully updated.'
      redirect_to students_path
    else
     render :edit 
    end
  end

  def courses_popup
    @courses = @student.try(:courses).pluck(:name)
    # render json: { content: @courses, formats: [:html], layout: false }    
    render json: { content: render_to_string('students/courses_list', locals: {courses: @courses},
          formats: [:html], layout: false) }
  end

  def pie_chart
    @data = [['girls', Student.where(gender: 'F').count ],
             ['boys', Student.where(gender: 'M').count ]]
  end

  def line_chart
    courses = Course.active
    @data = []
    courses.each do |course|
      @data << [course.name, course.students.count]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :dob, :gender, :contact_number, :active, :course_ids => [] )
    end
end
