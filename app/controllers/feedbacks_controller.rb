class FeedbacksController < ApplicationController

#load_and_authorize_resource

  # def index
  #   @feedbacks = Feedback.all.paginate :per_page => PER_PAGE, :page => params[:page]
  # end

  def new
    @feedback = Feedback.new    
    render json: {content: render_to_string('feedbacks/new', locals: {feedback: @feedback},
          formats: [:html], layout: false ) }
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      flash[:notice] =  "Thanks for your feedback"
      redirect_to root_path
    else
      render :new
    end
  end


  private
   
   # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:name, :user_comments)
    end

end
