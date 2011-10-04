require 'spec_helper'

def valid_attr
  {:debate_question_id => create(:debate_question).id, :user_id=> create(:user).id}
end

describe DebateVote do

  it { should respond_to(:debate_question) }
  it { should respond_to(:user) }

  describe "validations" do

    it "should not save instance 'without user'" do
      DebateVote.new(:debate_question_id => create(:debate_question).id).should_not be_valid
    end

    it "should not save instance 'without debate_questions'" do
      DebateVote.new(:user_id=> create(:user).id).should_not be_valid
    end

    it "should not accept instance with wrong 'current_vote'" do
      DebateVote.new(valid_attr.merge(:current_vote => 10)).should_not be_valid
    end

    [-1, 0, 1].each do |vote|
      it "should accept vote #{vote}" do
        DebateVote.new(valid_attr.merge(:current_vote => vote)).should be_valid
      end
    end

  end

  {"NO" => -1, "NEUTRAL" => 0, "YES" => 1}.each do |constant, value|
    it "should have constant #{constant} with value #{value}" do
      DebateVote.constants.should include constant
      eval("DebateVote::#{constant}").should eq(value)
    end
  end

  context "call" do
    it "named_scope #uniq_votes" do
      p Factory(:debate_vote).debate_question.user
    end
  end
end

# == Schema Information
#
# Table name: debate_votes
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)      not null
#  debate_question_id :integer(4)      not null
#  current_vote       :integer(4)      not null
#  created_at         :datetime
#  updated_at         :datetime
#

