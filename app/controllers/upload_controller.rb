# require 'aws-sdk'

class UploadController < ApplicationController

  def index

  end

  def upload

    # convert video
    if vidfile = convert_vid
      render :text => vidfile

      # push to s3
      # if s3_url = push_s3(vidfile)
      #   render :text => s3_url
      # else
      #   render :text => "failed s3 upload", :status => 500
      # end

    else
      render :text => "Failed!!!!!!!!!!!!!!", :status => 500
    end

    # File.delete(vidfile)

  end


private

def convert_vid
    upload_body = request.body.read
    data = JSON.parse(upload_body)

    audio = data['audio']
    video = data['video']

    # audio_raw = audio['contents'].split(',',2)[-1]
    video_raw = video['contents'].split(',',2)[-1]

    # decode from base64
    # audio_decoded = Base64.decode64(audio_raw)
    video_decoded = Base64.decode64(video_raw)

    # for local testing.
    directory = "public/uploads/video"
    # in heroku, can only write to tmp and logs. but can only read from public.
    # directory = "./tmp"

    # audio_path = File.join(directory, audio['name'].strip)
    video_path = File.join(directory, video['name'].strip)


    # File.open(audio_path,'wb') {|f| f.write(audio_decoded)}
    File.open(video_path, 'wb') {|f| f.write(video_decoded)}

    # puts audio['name'], video['name']

    # convert and save locally
    output_video_path = File.join(directory, video['name'].gsub('.webm', '_merged.webm'))
    # convert_command = "ffmpeg -i #{audio_path} -i #{video_path} -map 0:0 -map 1:0 #{output_video_path}"
    convert_command = "cp #{video_path} #{output_video_path}"

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