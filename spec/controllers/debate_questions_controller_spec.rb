require 'spec_helper'

describe DebateQuestionsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'#, :id => 1
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      post 'create'
      response.should be_success
    end
  end

end
