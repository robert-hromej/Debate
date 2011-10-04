require 'factory_girl'
require 'faker'
id_user = lambda{User.first.try(:id) || Factory(:user).id}
#
  def first_instance_of(instance, options = {})
    label = options[:factory_label] || instance
    klass = options[:class].blank? ? "#{instance.to_s.classify}.first" : "#{options[:class]}.first"
    obj = (eval(klass) or Factory.create(label))
    obj = obj.send(options[:method]) unless options[:method].nil?
    obj
  end
FactoryGirl.define do
 factory :user do
    sequence(:oauth_secret) { |n| "oauth-login#{n}"}
    sequence(:oauth_token) { |n| "oauth-secret#{n}"}
    sequence(:screen_name) { |n| "screen-name#{n}"}
 end

 factory :debate_vote do
    user_id { id_user }
    debate_question
    #sequence(:current_vote) { |n| Kernel::rand(1000)}
   current_vote {[0,1,-1].sample}
 end

  factory :dquestion_ass, :class => DebateQuestion do
    sequence(:body) {Faker::Lorem.sentence(2)}
  end

  factory :debate_question do
    sequence(:body) {Faker::Lorem.sentence(2)}
    user_id { first_instance_of :user, :method => :id }
   end

  factory :comment do
    user_id { first_instance_of :user, :method => :id }
    sequence(:body) {Faker::Lorem.sentence(2)}
    debate_question_id { DebateQuestion.first.try(:id) || Factory(:debate_vote).id }
  end

  factory :comment_vote do
    user_id { User.first.try(:id) || Factory(:user).id }
    comment_id {Comment.first.try(:id) || Factory(:comments).id}
  end

end