require 'spec_helper'

describe Comment do
  before(:all) do
    @attr = {:user_id => 1, :debate_question_id => 1, :counter => 0, :body => "55555555", :vote => 0}
  end

  it { should respond_to(:user_id)}
  it { should respond_to(:user)}
  it { should respond_to(:debate_question_id) }
  it { should respond_to(:debate_question) }
  it { should respond_to(:counter) }
  it { should respond_to(:body) }
  it { should respond_to(:vote) }


  it "should be valid with valid attributes" do
    Comment.new(@attr).should be_valid
  end

  it "should not be valid without body" do
    Comment.new(@attr.merge(:body => "")).should_not be_valid
  end

  it "should not be valid with short body" do
    Comment.new(@attr.merge(:body => "bo")).should_not be_valid
  end

  it "should not be valid with long body" do
    body = "a" * 257
    Comment.new(@attr.merge(:body => body)).should_not be_valid
  end

  it "should not be valid without user" do
    Comment.new(@attr.merge(:user_id => nil)).should_not be_valid
  end

  it "should not be valid without debate question" do
    Comment.new(@attr.merge(:debate_question_id => nil)).should_not be_valid
  end

  it "should not be valid without vote" do
    Comment.new(@attr.merge(:vote => nil)).should_not be_valid
  end

  it "should increase votes counter" do
    comment = Factory(:comment)
    comment.stub(:comment_votes => Array.new(20))
    comment.recounting
    comment.counter.should eq(20)
  end

  it "should try if user voted" do
    comment = Factory(:comment)
    comment.stub(:comment_votes => stub(:where => ["4"]))
    comment.vote?(4).should eq(true)
  end

end

# == Schema Information
#
# Table name: comments
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)      not null
#  debate_question_id :integer(4)      not null
#  counter            :integer(4)      default(0), not null
#  body               :string(255)     not null
#  vote               :integer(4)      default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#

