namespace :db do
  desc "Clear both test and real databases"
  task :prepare => :environment do
    Rake::Task['db:migrate:reset'].invoke
    Rake::Task['db:test:prepare'].invoke
  end
  end
namespace :db do
  desc "Clear both test and real databases"
  task :populate => :environment do
    Faker(:user,:screen_name => "MrTime1",
          :oath_token => "96224774-6y24QMHPGCPuM15cTR4ooASl1luSVUch4s1gFpwj4",
          :oauth_secret => "myvoPdK0EUfAsbghKV3eNuIBUQmOWjUxnKGn8jGuw0")

  end
end