require 'spec_helper'

describe CommentVote do
  before(:all) do
    @attr = {:user_id => 1, :comment_id => 1}
  end
  subject { CommentVote.new }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:comment_id) }
  it { should respond_to(:comments) }

  it "should not be valid without user" do
    CommentVote.new(@attr.merge(:user_id => nil)).should_not be_valid
  end

  it "should not be valid without comments" do
    CommentVote.new(@attr.merge(:comment_id => nil)).should_not be_valid
  end

end

# == Schema Information
#
# Table name: comment_votes
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)      not null
#  comment_id :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

