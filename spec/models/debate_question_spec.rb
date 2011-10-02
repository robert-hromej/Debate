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
      DebateQuestion.new(:body => "Hello, Membas!").should_not be_valid
    end
  end

end

# == Schema Information
#
# Table name: debate_questions
#
#  id            :integer(4)      not null, primary key
#  user_id       :integer(4)
#  body          :string(255)     not null
#  yes_count     :integer(4)      default(0)
#  no_count      :integer(4)      default(0)
#  neutral_count :integer(4)      default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

