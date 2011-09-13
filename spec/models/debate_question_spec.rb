require 'spec_helper'



describe DebateQuestion do
  context "should respond" do
    subject { DebateQuestion.new }
    it { should respond_to(:user) }
    it { should respond_to(:debate_votes) }
    it { should respond_to(:comments) }
  end

  describe "validations" do
      it "should not pass 'about' higher than 256" do
        DebateQuestion.new(:body => ("a" * 300), :user_id => create(:user)).should_not be_valid
      end
      it "should pass valid 'about'"do
        DebateQuestion.new(:body => "Hello, Membas!", :user_id => create(:user)).should be_valid
      end
  end
end
