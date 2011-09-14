require 'spec_helper'

describe User do

  before(:each) do
    @attr={:screen_name=>"Name", :oauth_token=>"token", :oauth_secret => "secret"}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require screen_name" do
    no_name_user=User.new(@attr.merge(:screen_name=>""))
    no_name_user.should_not be_valid
  end

  it "should require oauth_secret" do
    no_secret_user = User.new(@attr.merge(:oauth_secret => ""))
    no_secret_user.should_not be_valid
  end

  it "should require oauth_token" do
    no_token_user = User.new(@attr.merge(:oauth_token => ""))
    no_token_user.should_not be_valid
  end

  describe "created user" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have profile_image method" do
      @user.should respond_to(:profile_image)
    end

    it "should have valid profile_image" do
      pending
      (@user.profile_image == '/images/no-avatar.png').should be_true
    end

    it "should have profile_url method" do
      @user.should respond_to(:profile_url)
    end

    it "should have valid profile_url" do
      (@user.profile_url == "http://twitter.com/Name").should be_true
    end

    it "should have many debate questions" do
      @user.should respond_to(:debate_questions)
    end

    it "should have many comments" do
      @user.should respond_to(:comments)
    end

    it "should have many comment votes" do
      @user.should respond_to(:comment_votes)
    end

    it "should have uniq screen_name" do
      user = User.new(@attr)
      user.should_not be_valid
    end

  end
end
