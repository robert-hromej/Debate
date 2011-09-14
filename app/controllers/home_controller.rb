class HomeController < ApplicationController
  def index
    @top_debates = DebateQuestion.all_debates(:top).limit(5)
    @recent_debates = DebateQuestion.all_debates(:recent).limit(5)
    @new_debate_question = DebateQuestion.new
  end

end
