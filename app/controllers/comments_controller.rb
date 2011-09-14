class CommentsController < ApplicationController
  def create
    debate_question = DebateQuestion.find(params[:debate_question_id])
    @comment = debate_question.comments.create(params[:comment].merge(:user_id => current_user.id))

    push_error_message @comment.errors

    redirect_to debate_question
  end

end
