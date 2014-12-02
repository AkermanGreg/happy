class VideosController < ApplicationController

  skip_before_filter :verify_authenticity_token
 
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
 
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end
 
  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'
 
      render :text => '', :content_type => 'text/plain'
    end
  end


  def new
    @question = Question.find(params[:question_id])
    @video = Video.new
    
  end

  def index
    @videos = Video.all
  end

  def upload

    # convert video
    if vidfile = convert_vid

      # push to s3 if production or else save locally
      if Rails.env == 'production'
        if s3_url = push_s3(vidfile)
          render :text => s3_url
        else
          render :text => "failed s3 upload", :status => 500
        end

      else
        vidfile = vidfile.gsub('public','')
        render :text => vidfile
      end

    else
      render :text => "Failed!!!!!!!!!!!!!!", :status => 500
    end

    File.delete(vidfile) unless Rails.env == 'development'

  end


  def save

    # save video to db
    @video = Video.new(params.permit(:filepath, :question_id, :user_id))

    if @video.save
      redirect_to user_path(session[:user_id])
    else
      render 'new'
    end

  end

  def show
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to question_path(id: @video.question_id)
  end


private

  def video_params
    params.require(:video).permit(:filepath, :question_id, :user_id)
  end

  def convert_vid
      upload_body = request.body.read
      data = JSON.parse(upload_body)

      audio = data['audio']
      video = data['video']

      audio_raw = audio['contents'].split(',',2)[-1]
      video_raw = video['contents'].split(',',2)[-1]

      # decode from base64
      audio_decoded = Base64.decode64(audio_raw)
      video_decoded = Base64.decode64(video_raw)

      # for local testing.
      # directory = "public/uploads/video"
      # in heroku, can only write to tmp and logs. but can only read from public.
      directory = "./tmp"

      audio_path = File.join(directory, audio['name'].strip)
      video_path = File.join(directory, video['name'].strip)

      File.open(audio_path,'wb') {|f| f.write(audio_decoded)}
      File.open(video_path, 'wb') {|f| f.write(video_decoded)}

      # puts audio['name'], video['name']

      # convert and save locally
      output_video_path = File.join(directory, video['name'].gsub('.webm', '_merged.webm'))

      convert_command = "ffmpeg -i #{audio_path} -i #{video_path} -map 0:0 -map 1:0 #{output_video_path}" 

      if Rails.env == 'development'
        output_video_path = File.join('public/uploads/video', video['name'].gsub('.webm', '_merged.webm'))
        convert_command = "cp #{video_path} #{output_video_path}"
      end

      system(convert_command)

      if $? != 0
        return
      end

      File.delete(audio_path, video_path)

      return output_video_path

  end

  def push_s3(local_fpath)

    s3 = AWS::S3.new(
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'])

    bucket = s3.buckets["kentuckyfrychicken"]

    fname = File.basename(local_fpath)

    s3_object = bucket.objects["#{fname}"]
    x = s3_object.write(
          File.open(local_fpath), 
          :content_length => File.size(local_fpath),
          :server_side_encryption => :aes256,
          :acl => :public_read
      )

    return s3_object.public_url
    # return s3_object.url_for(:read)
    # return "http://kentuckyfrychicken.s3.amazonaws.com/#{fname}"

  end

end