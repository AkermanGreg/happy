class Video < ActiveRecord::Base
	field :datesubmitted, type: DateTime
	field :filepath, type: String

	 # belongs_to :user
	 # belongs_to :question
	 # has_many :comments
	 # has_many :hashtags
end


