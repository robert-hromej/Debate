#Session.destroy_all
User.destroy_all
DebateQuestion.destroy_all
DebateVote.destroy_all
Comment.destroy_all
CommentVote.destroy_all

User.transaction do
  1000.times do |i|
    User.create!(:screen_name => Faker::Name.first_name + i.to_s,
                 :oauth_token => "oauth_token",
                 :oauth_secret => "oauth_secret")
  end
end
puts "created #{User.all.size} users"
users = User.all

DebateQuestion.transaction do
  25.times do
    DebateQuestion.create!(:user_id => users.shuffle.first.id, :body => Faker::Lorem.sentence(10))
  end
end
puts "created #{DebateQuestion.all.size} debate_questions"
debate_questions = DebateQuestion.all

Comment.transaction do
  1000.times do
    Comment.create!(:user => users.shuffle.first,
                    :debate_question => debate_questions.shuffle.first,
                    :body => Faker::Lorem.sentence(5),
                    :vote => rand(3)-1)
  end
end
puts "created #{Comment.all.size} comments"
comments = Comment.all

CommentVote.transaction do
  comments.each do |comment|
    users.shuffle[0..(rand(3)+2)].each do |user|
      CommentVote.create!(:user => user, :comment => comment)
    end
  end
end
puts "created #{CommentVote.all.count} comment_votes"

DebateVote.transaction do
  10000.times do
    DebateVote.create!(:user => users.shuffle.first,
                       :current_vote => rand(3)-1,
                       :debate_question => debate_questions.shuffle.first,
                       :created_at => rand(3600*24*7).seconds.ago)
  end
end
puts "created #{DebateVote.all.count} debate_votes"
