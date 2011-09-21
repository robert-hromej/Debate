class CommentsController < ApplicationController
  before_filter :is_logged?, :except => [:index]

  def create
    @debate_question = DebateQuestion.find(params[:debate_question_id])
    @debate_question.comments.create!(params[:comment].merge(:user_id => current_user.id))
    @comments = @debate_question.comments.paginate(:page => 1)
  rescue StandardError => ex
    push_error_message ex.record.errors
  end

  def index
    @debate_question = DebateQuestion.find(params[:debate_question_id])
    @comments = @debate_question.comments.paginate(:page => params[:page])
  end

end
