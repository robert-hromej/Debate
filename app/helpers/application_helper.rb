module ApplicationHelper
  def system_messages
    return "" if session[:system_message].blank?
    str = render(:partial => "layouts/sys_messages")
    session[:system_message] = nil
    str.html_safe
  end
end
