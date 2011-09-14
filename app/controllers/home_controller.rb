class HomeController < ApplicationController
  def index
    @top_debates = DebateQuestion.top_debates
    @recent_debates = DebateQuestion.recent_debates
    @new_debate_question = DebateQuestion.new
  end

end
