root = File.expand_path(File.dirname(__FILE__))
require File.join(root, "../", "config", "environment")
require 'spawnling'
require 'rubygems'
require 'clockwork/database_events'
require 'sidekiq/cli'
require 'csv'
require 'timeout'

class Workers

  def Workers.start
    puts 'starting workers'
    if Workers.pidfiles.any?
      puts "Workers have already started."
    else
      SidekiqLauncher.run_all
      ClockworkLauncher.run
    end
  rescue => er
    puts er.message
    puts er.backtrace
  ensure
    Workers.stop
  end

  def Workers.stop
    if Workers.pids.any?
      Workers.pids.each do |pid|
        Halter.stop(pid)
      end
    else
      puts "No workers currently running"
    end
  end

  def Workers.status
    puts "Status of Biorails Daemons:"
    Workers::StatusCheck.run
    puts "\nStatus of Sidekiq queues"
    Workers::QueueCheck.run
    puts "\nStatus of running jobs"
    Workers::JobCheck.run
  end

  private

  def Workers.pids
    Workers.pidfiles.map do |path|
      IO.binread(path)
    end
  end

  def Workers.pidfiles
    Dir[File.join(Rails.root, 'tmp', 'pids', 'worker_*.pid')]
  end

  def Workers.make_pidfile(name, pid)
    puts "Making pidfile #{name}"
    path = File.join(Rails.root, 'tmp', 'pids', "worker_#{name}_#{pid}.pid")
    File.open(path, 'w') {|f| f.write(pid)}
  end

end
