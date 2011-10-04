class CommentVotesController < ApplicationController

  before_filter :is_logged?

  def create
    @comment = Comment.find(params[:comment_id])
    @comment.comment_votes.create(:user_id => current_user.id)
    @comment.reload
    push_notice_message t('notice.success.comment_voted')
  end

end
