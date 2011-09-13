require 'factory_girl'
require 'faker'

FactoryGirl.define do
 factory :user do
    sequence(:oauth_login) { |n| "oauth-login#{n}"}
    sequence(:oauth_secret) { |n| "oauth-secret#{n}"}
    sequence(:screen_name) { |n| "screen-name#{n}"}
 end

 factory :debate_vote do
    user
    dquestion_ass
    sequence(:current_vote) { |n| Kernel::Rand(1000)}
 end

  factory :dquestion_ass, :class => DebateQuestion do
    sequence(:body) {Faker::Lorem.sentence(2)}
  end

  factory :debate_question do
    sequence(:body) {Faker::Lorem.sentence(2)}
    user
   end

  factory :comment do
    user_id { User.first.try(:id) || Factory(:user).id }
    sequence(:body) {Faker::Lorem.sentence(2)}
    debate_question_id {DebateQuestion.first.try(:id) || Factory(:debate_vote).id}
  end

end