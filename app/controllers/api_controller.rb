class ApiController < ApplicationController
    def index
      questions = Question.all
      render json: questions, status: 200
    end

    # def new
    #   @question = Question.new
    # end

    def show
      question = Question.find(params[:id])
      render json: question, status: 200

    end

    # def create
    #   @question = Question.new(question_params)
    #   if @question.save
    #     redirect_to api_questions_path
    #   else
    #     render "new"
    #   end
    # end

    # def edit
    #   @question = Question.find(params[:id])
    # end

    # def update
    #     @question = Question.find(params[:id])
    #     if @question.update_attributes(question_params)
    #       redirect_to api_questions_path
    #     else
    #       render 'edit'
    #     end
    #   end

    # def destroy
    #   @question = Question.find(params[:id])
    #   @question.destroy
    #   redirect_to api_questions_path
    # end

    private
      def question_params
        params.require(:question).permit(:the_question, :user_id)
      end
end

