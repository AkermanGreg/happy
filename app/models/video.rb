class Video < ActiveRecord::Base
	

belongs_to :user
belongs_to :question
has_many :videos
	 # has_many :hashtags
end


