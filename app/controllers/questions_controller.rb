  class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  

  end

  def new
    @question = Question.new

    if !current_user
      redirect_to new_user_path
    end
  end

  def show
    @question = Question.find(params[:id])
    # @question = Question.find(params[:question_id])
    @video = Video.new

  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path
    else
      render "new"
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
      @question = Question.find(params[:id])
      if @question.update_attributes(question_params)
        redirect_to questions_path
      else
        render 'edit'
      end
    end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

 private
  def question_params
    params.require(:question).permit(:the_question, :user_id, :videos => [:id])
  end
end
