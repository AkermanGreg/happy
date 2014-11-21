class Comment < ActiveRecord::Base
  belongs_to :videos
  belongs_to :user

  validate_length_of :comment, minimum: 3, maximum: 500

end