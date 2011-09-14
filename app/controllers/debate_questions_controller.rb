class DebateQuestionsController < ApplicationController

  def index
    @debates = DebateQuestion.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @debate_question = current_user.debate_questions.find(params[:id])
  end

  def create
    debate_question = current_user.debate_questions.create(params[:debate_question])

    if debate_question
      push_error_message t(:debate_created)
      redirect_to debate_question
    else
      push_error_message t(:debate_not_valid)
      redirect_to root_path
    end
  end

end
