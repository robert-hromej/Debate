class DebateVotesController < ApplicationController

  before_filter :is_logged?

  def create
    @debate = DebateQuestion.find(params[:debate_question_id])
    vote = @debate.debate_votes.new
    vote.current_vote = params[:vote]
    vote.user_id = current_user.id
    vote.save
    @debate.reload
    push_notice_message "you success voted..."
  rescue StandardError => ex
    push_error_message "you already voted..."
  end

end
