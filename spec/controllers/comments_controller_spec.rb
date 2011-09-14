require 'spec_helper'

describe CommentsController do

  describe "GET 'new'" do
    it "should be successful" do
      post 'create'#, :debate_question_id => 1
      response.should be_success
    end
  end

end
