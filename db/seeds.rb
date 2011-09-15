#Session.destroy_all
User.destroy_all
DebateQuestion.destroy_all
DebateVote.destroy_all
Comment.destroy_all
CommentVote.destroy_all

1000.times do
  User.create!(:screen_name => Faker::Name.first_name, :oauth_token => "oauth_token", :oauth_secret => "oauth_secret")
end
puts "created 1000 users"
users = User.all

50.times do
  DebateQuestion.create!(:user_id => users.shuffle.first.id, :body => "Debate body text....")
end
puts "created 50 debate_questions"
debate_questions = DebateQuestion.all

200.times do
  Comment.create!(:user => users.shuffle.first, :debate_question => debate_questions.shuffle.first,
                  :body => "Comment...", :vote => rand(3)-1)
end
puts "created 200 comments"
comments = Comment.all

comments.each do |comment|
  users.shuffle[0..(rand(5)+5)].each do |user|
    CommentVote.create!(:user => user, :comment => comment)
  end
end
puts "created #{CommentVote.all.count} debate_votes"

debate_questions.each do |debate_question|
  users.shuffle[0..500].each do |user|
    DebateVote.create!(:user => user, :current_vote => rand(3)-1, :debate_question => debate_question, :updated_at => Time.now + rand(3600*24*30))
  end
end
puts "created #{DebateVote.all.count} debate_votes"


