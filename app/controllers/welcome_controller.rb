class WelcomeController < ApplicationController

  def index
    @questions = Question.all
    @videos = Video.all
  end

end