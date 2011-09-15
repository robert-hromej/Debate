module ApplicationHelper

  def system_messages
    return "" if session[:system_message].blank?
    str = render(:partial => "layouts/sys_messages")
    session[:system_message] = nil
    str.html_safe
  end

  def voted?(record, vote = :yes)
    case
      when record.is_a?(Comment)
        record.comment_votes.index do |comment_vote|
          comment_vote.user_id == controller.current_user.id
        end
      when record.is_a?(DebateQuestion)
        record.debate_votes.index do |debate_vote|
          debate_vote.user_id == controller.current_user.id and debate_vote.vote?(vote)
        end
      else
        raise
    end
  end

  def comment_vote_button(comment)
    button_to "+1", comment_comment_votes_path(comment),
              :remote => true, :method => :post, :disabled => voted?(comment)
  end

end
