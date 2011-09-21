class ApplicationController < ActionController::Base
  protect_from_forgery

  # finds current user record in table 'users' using id stored in session
  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

  # save user id in session
  def set_current_user(user)
    @current_user = user
    session[:current_user_id] = (user ? user.id : nil)
  end

  def authorized?
    !!current_user
  end

  # add notice message, which will be printed in layout with green color
  def push_notice_message(msg)
    push_message(:notice, msg)
  end

  # add error message, which will be printed in layout with red color
  def push_error_message(msg)
    push_message(:error, msg)
  end

  # add message
  def push_message(type, msg)
    session[:system_message] ||= {:notice => [], :error => []}
    if msg.is_a?(::Hash)
      msg.full_messages.each do |m|
        session[:system_message][type] << m
      end
    else
      session[:system_message][type] << msg
    end
  end

  private

  # can be used in 'before_filter' to verify user authorization
  def is_logged?
    if current_user.blank?
      respond_to do |format|
        push_notice_message t(:please_login)

        format.html {
          redirect_to root_url
        }
        format.js {
          render :update do |page|
            page.call "system_message", escape_javascript(system_messages)
          end
        }
      end
    end
  end
end
