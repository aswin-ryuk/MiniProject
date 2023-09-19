class CoursesController < ApplicationController

load_and_authorize_resource

  before_action :allow_params, only: [:index, :sorting_list]

  def index
    if params[:search].present? 
      conditions = []
      if params[:search][:name].present?
        conditions << "lower(name) LIKE '%#{params[:search][:name].downcase}%'"
        session[:filters_name] = params[:search][:name]
      end
      if params[:search][:description].present?
        conditions << "lower(description) LIKE '%#{params[:search][:description].downcase}%'"    
        session[:filters_desc] = params[:search][:description]
      end
      courses = Course.where(conditions.first).where(conditions.second).order("position")
    else
      courses = Course.order("position")
    end
    session[:filter_type] = params[:filter_type] if params[:filter_type]
    filter_type = session[:filter_type] || 'all'
    courses = dropdown_filter(filter_type, courses)
    session[:courses_list] = courses
    @page_num =  params[:page].present? ? params[:page] : 1
    @courses = courses.paginate :per_page => PER_PAGE, :page => params[:page]
    refresh_table
  end

  def populate_courses
    @courses=  Course.order(:name).where("lower(name) LIKE '%#{params[:term].downcase}%'").map(&:name) 
    render json: @courses
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = t('common.created',model_name: Course.model_name)
      redirect_to courses_path
    else
      render :new 
    end
  end

  def update
    if @course.update(course_params)
      flash[:notice] = t('common.updated',model_name: Course.model_name)
      redirect_to courses_path
    else
      render :edit 
    end
  end


  def active_deactive
    @course.update_attribute('active', (@course.active == 'Y' ? 'N' : 'Y'))
    flash[:notice] = "Modified the status successfully"
    render js: "window.location = '#{courses_path}'"
  end

  def sorting_list
    params[:sorting_ids].each_with_index do |id, index|
      record = Course.where(id: id).first
      record.update_column(:position, ((params[:page].to_i*PER_PAGE-PER_PAGE)+(index+1))) if record.present?
    end
    render js: "window.location = '#{courses_path(page: params[:page])}'"  
  end

  def clear_fliter
    session[:filters_name] = nil
    session[:filters_desc] = nil
    render js: "window.location = '#{courses_path}'"
  end

  def export_csv
    content = generate_course_list(Course.all.order("position"), view_context.courses_list_columns.collect{ |r| r[:label] })
    # Send the file
    filename = "courses_list.csv"
    send_data  content, :type => 'text/csv', :filename =>  filename, :disposition => 'attachment'
  end

  def export_pdf    
    courses = Course.order("position")
    # Create the PDF document
    pdf = Prawn::Document.new
    pdf.move_down 10
    pdf.text "Courses List", size: 13, align: :center, font_style: :bold
    pdf.move_down 10

    data= []
    data << [ 'Name', 'description', 'active','position']

    courses.each {|c|
              data.push([ c.name, c.description, c.active, c.position])
       }
    pdf.table(data, header: true, position: :center, column_widths: [150, 150, 100]) do |table|    
        table.row(0).font_style = :bold
        table.row(0).cell_style = { :text_color => "fafafb"}
        table.row(0).background_color = 'd9d9d9'
    end 

    download_pdf(pdf, "report.pdf")

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description, :position, :active)
    end

    def download_pdf(pdf, displayed_filename)
      begin
        send_data pdf.render, :filename => displayed_filename
      rescue Exception => ex
        logger.error("Failed to download the pdf file : #{displayed_filename} ! " + ex)
        flash[:error] = 'Failed to download the pdf file !'
        redirect_to :action => 'index'
      end
    end



    def allow_params
      params.permit!
      # params.permit(:filter_type, :page)
      # params.permit(sorting_ids: [])
      # params.permit(search: {})
    end

    def dropdown_filter(filter_type, courses)
      status = case filter_type
      when 'all'        
        return courses
      when 'active'    
        'Y'
      when 'inactive'     
        'N'
      end
      courses.where(active: status).order("position")    
    end
end
