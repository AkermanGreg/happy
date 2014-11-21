class VideosController < ApplicationController

  def index
    @videos = Video.all
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
      redirect_to questions_path
    else
      render "new"
    end
  end

 private
  def video_params
    params.require(:video).permit(:filepath, :user_id)
  end
end
end
