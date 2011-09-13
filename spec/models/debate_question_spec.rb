require 'spec_helper'



def invalid_attr
end

describe DebateQuestion do
  context "should respond" do
    subject { DebateQuestion.new }
    it { should respond_to(:user) }
    it { should respond_to(:debate_votes) }
    it { should respond_to(:comments) }
  end

  describe "validations" do
      it "should not pass 'about' higher than 256" do
        DebateQuestion.new(:body => ("a" * 300)).should_not be_valid
      end
      it "should pass valid 'about'"do
        DebateQuestion.new(:body => "Hello, Membas!").should be_valid
      end
  end
end
