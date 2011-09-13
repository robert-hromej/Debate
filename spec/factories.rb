require 'factory_girl'
require 'faker'

FactoryGirl.define do
 factory :user do
    sequence(:oauth_login) { |n| "oauth-login#{n}"}
    sequence(:oauth_secret) { |n| "oauth-secret#{n}"}
    sequence(:screen_name) { |n| "screen-name#{n}"}
 end
end