require 'spec_helper'
def valid_attr
  {:debate_question_id => create(:debate_question).id,:user_id=> create(:user).id}
end
describe DebateVote do
  subject{ DebateVote.new }
  it{should respond_to(:debate_question)}
  it{should respond_to(:user)}

  describe "validations" do
    it "should not saved 'without user'" do
      DebateVote.new(:debate_question_id => create(:debate_question).id).should_not be_valid
    end
    it "should not saved 'without debate_questions'" do
      DebateVote.new(:user_id=> create(:user).id).should_not be_valid
    end
    it "should not accept wrong 'current_vote'" do
      DebateVote.new(valid_attr.merge(:current_vote  => 10)).should_not be_valid
    end
    context "should accept [-1,0,1]" do
      it "Try 1" do
        DebateVote.new(valid_attr.merge(:current_vote  => 1)).should be_valid
      end
      it "Try 0" do
        DebateVote.new(valid_attr.merge(:current_vote  => 0)).should be_valid
      end
      it "Try -1" do
        DebateVote.new(valid_attr.merge(:current_vote  => -1)).should be_valid
      end
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

