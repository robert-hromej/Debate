class User < ActiveRecord::Base

  has_many :debate_votes
  has_many :debate_questions
  has_many :comments
  has_many :comment_votes

  validates :screen_name, :presence => true, :length => {:maximum => 255}, :uniqueness => true
  validates :oauth_secret, :presence => true
  validates :oauth_token, :presence => true

  # generate twitter's url for getting profile image using screen name
  def profile_url
    "http://twitter.com/#{self.screen_name}"
  end

  def profile_image
    "http://api.twitter.com/1/users/profile_image/#{self.screen_name}.json?size=normal"
  end

  # searches user using screen name or create new one with specific oauth token and secret
  def self.login(credentials, result)
    # use exiting record for already registered users
    u = User.where(:screen_name => credentials.screen_name).first
    # Creates record in table user for new user
    u ||= User.create(:screen_name => credentials.screen_name, :oauth_token => result.token, :oauth_secret => result.secret)
  end

  # create complete Twitter::Client object for working with twitter under specific user account
  def client
    options = {
        :consumer_key => APP_CONFIG[:twitter][:consumer_token],
        :consumer_secret => APP_CONFIG[:twitter][:consumer_secret],
        :oauth_token => self.oauth_token,
        :oauth_token_secret => self.oauth_secret
    }
    Twitter::Client.new(options)
  end
end

# == Schema Information
#
# Table name: users
#
#  id           :integer(4)      not null, primary key
#  screen_name  :string(255)
#  oauth_token  :string(255)
#  oauth_secret :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

