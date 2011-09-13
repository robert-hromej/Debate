require 'spec_helper'

describe CommentVote do
  before(:all) do
    @attr = {:user_id => 1, :comment_id => 1}
  end
  subject { CommentVote.new }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:comment_id) }
  it { should respond_to(:comment) }

  it "should not be valid without user" do
    CommentVote.new(@attr.merge(:user_id => nil)).should_not be_valid
  end

  it "should not be valid without comment" do
    CommentVote.new(@attr.merge(:comment_id => nil)).should_not be_valid
  end


end
