class VideosController < ApplicationController

  def index
    @videos = Video.all

    render json: planets, status: 200
  end

  def new
    @video = Video.new
   
  end

  def show
    @video = Video.find(params[:id])
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to videos_path
    else
      render "new"
    end
  end

 private
  def video_params
    params.require(:video).permit(:filepath, :user_id, :the_answer)
  end
end

