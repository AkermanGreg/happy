class VideosController < ApplicationController

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
   
  end

  def show
    @video = Video.find(params[:id])
    @question = Question.find(@video.question.id)
    @users = User.all
  end

  def create
    @user = current_user
    question = Question.find(params[:question_id])
    @video = Video.new(:the_answer => params[:the_answer])
    @video.user_id = @user.id
    question.videos << @video
    if @video.save
      redirect_to videos_path
    else
      render "new"
    end
  end

 private
  def video_params
    params.require(:video).permit(:filepath, :user_id, :the_answer, :question_id)
  end
end

