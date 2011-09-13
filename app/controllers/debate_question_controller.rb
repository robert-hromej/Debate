class DebateQuestionController < ApplicationController

  def index
    @debates = DebateQuestion.paginate(:page => params[:page], :per_page => 20)
  end

  def show
  end

  def new
  end

end
