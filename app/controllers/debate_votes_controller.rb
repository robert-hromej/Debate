class DebateVotesController < ApplicationController

  before_filter :is_logged?

  def create
    @debate = DebateQuestion.find(params[:debate_question_id])
    vote = @debate.debate_votes.where(:user_id => current_user.id).first || @debate.debate_votes.new
    vote.current_vote = params[:vote]
    vote.user_id = current_user.id
    vote.save
    @debate.reload
    @analytics_data = @debate.analytics_data
    push_notice_message t('notice.success.debate_voted')
  rescue StandardError => ex
    push_error_message t('error.you_already_debate_voted')
  end

end
