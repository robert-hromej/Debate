namespace :db do
  desc "Clear both test and real databases"
  task :prepare => :environment do
    Rake::Task['db:migrate:reset'].invoke
    Rake::Task['db:test:prepare'].invoke
  end
end