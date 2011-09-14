require 'spec_helper'

describe CommentVotesController do

  describe "GET 'new'" do
    it "should be successful" do
      post 'create'#, :comment_id => 1
      response.should be_success
    end
  end

end
