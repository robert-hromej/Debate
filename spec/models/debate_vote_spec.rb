require 'spec_helper'

describe DebateVote do
  subject{ DebateVote.new }
  it{should respond_to(:debate_question)}
  it{should respond_to(:user)}

  describe "validations" do
    it "should not saved 'without user'" do
      #DebateVote.new(:debate_question)
    end
    it "should not saved 'without debate_question'"
    context "should accept [-1,0,1]" do
      it "Try 1"
      it "Try 0"
      it "Try -1"
    end
  end
end
