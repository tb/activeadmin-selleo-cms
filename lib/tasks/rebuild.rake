namespace :db do
  desc "Drops, creates and migrates db"

  task(:rebuild => :environment) do
    puts "Dropping db"
    Rake::Task['db:drop'].invoke
    puts "Creating db"
    Rake::Task['db:create'].invoke
    puts "Migrating db"
    Rake::Task['db:migrate'].invoke
    puts "Loading seeds"
    Rake::Task['db:seed'].invoke
    if Rails.env.test?
      puts "Creating db snapshot"
      excluded_tables = ["schema_migrations"].collect { |t| "-T #{t}" }.join(" ")
      db_config = ActiveRecord::Base.configurations[ENV["RAILS_ENV"]]
      `pg_dump -i -a -x #{excluded_tables} -O #{db_config["database"]} -p #{db_config["port"]} -f db/snapshots/test_database.sql`
    end
  end
end