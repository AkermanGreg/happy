class Question < ActiveRecord::Base
  belongs_to :user
  has_many :videos     

  validates_length_of :the_question, minimum: 10, maximum: 500

end 