require 'spec_helper'


describe DebateQuestion do
  subject { DebateQuestion.new }
  it { should respond_to(:user) }
  it { should respond_to(:debate_votes) }
  it { should respond_to(:debate_yes_votes) }
  it { should respond_to(:debate_no_votes) }
  it { should respond_to(:debate_neutral_votes) }
  it { should respond_to(:comments) }

  describe "validations" do
    before { @user = create(:user) }
    it "should not pass 'about' higher than 256" do
      DebateQuestion.new(:body => ("a" * 300), :user_id => @user.id).should_not be_valid
    end

    it "should pass valid 'about'" do
      DebateQuestion.new(:body => "Hello, Membas!", :user_id => @user.id).should be_valid
    end

    it "should not save instance 'with no user'" do
      DebateQuestion.new(:body => "Hello, Membas!").should be_valid
    end
  end
  it "s" do
    create(:comment)
  end
end
