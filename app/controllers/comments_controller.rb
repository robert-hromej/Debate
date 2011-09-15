class CommentsController < ApplicationController

  before_filter :is_logged?

  def create
    debate_question = DebateQuestion.find(params[:debate_question_id])
    @comment = debate_question.comments.create!(params[:comment].merge(:user_id => current_user.id))
  rescue StandardError => ex
    push_error_message ex.record.errors
  end

end
