class DebateQuestionsController < ApplicationController

  before_filter :is_logged?, :except => [:index]

  def index
    @debates = DebateQuestion.all_debates(:recent).paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @debate_question = DebateQuestion.includes(:comments => :comment_votes).find(params[:id])
  end

  def create
    debate_question = current_user.debate_questions.create!(params[:debate_question])

    push_error_message t(:debate_created)
    redirect_to debate_question

  rescue StandardError => ex
    push_error_message t(:debate_not_valid)
    redirect_to root_path
  end

end
