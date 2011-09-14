class CommentVotesController < ApplicationController

  before_filter :is_logged?

  def create
    comment = Comment.find(params[:comment_id])
    @vote = comment.comment_votes.create(:user_id => current_user.id)

    redirect_to comment.debate_question
  end

end
