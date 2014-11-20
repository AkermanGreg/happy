class Video < ActiveRecord::Base
  attr_accessible :date_submitted, :filepath

  belongs_to :user
  belongs_to :question
  has_many :videos

end


