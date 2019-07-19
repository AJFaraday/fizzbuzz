namespace :jobs do

  desc "Run all sidekiq configurations from /config/sidekiq/*.yml"
  task :work do
    require_relative '../../lib/workers.rb'
    Workers.stop
    Workers.start
  end

  desc "Stop any currently running processes (or clear out pids for stopped ones)"
  task :stop do
    require_relative '../../lib/workers.rb'
    Workers.stop
  end

  desc "Check on the status of background workers"
  task :status => :environment do
    Workers.status
  end

end
