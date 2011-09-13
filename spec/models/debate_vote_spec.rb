require 'spec_helper'

describe DebateVote do
  subject{ DebateVote.new }
  it{should respond_to(:debate_question)}
  it{should respond_to(:user)}

  describe "validations" do
    it "should not saved 'without user'"
    it "should not saved 'without debate_question'"
    context "should accept [-1,0,1]" do

    end
  end
end
