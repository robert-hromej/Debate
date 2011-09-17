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
        record.vote?(controller.current_user.id)
      when record.is_a?(DebateQuestion)
        record.vote?(controller.current_user.id) == vote
      else
        raise
    end
  end

  def comment_vote_button(comment)
    button_to "+1", comment_comment_votes_path(comment),
              :remote => true, :method => :post, :disabled => voted?(comment)
  end

end
