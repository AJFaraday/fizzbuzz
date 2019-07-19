class Workers

  class ClockworkLauncher

    def ClockworkLauncher.run
      new.run
    end

    def run
      puts "Starting 'clockwork' scheduler"
      ActiveRecord::Base.connection.disconnect!
      ActiveRecord::Base.establish_connection
      Clockwork.manager = ::Clockwork::DatabaseEvents::Manager.new
      Clockwork.configure do |config|
        config[:logger] = Logger.new("#{Rails.root}/log/clockwork.log")
      end
      Clockwork.sync_database_events(model: JobSchedule, every: 30.second) do |database_event|
        database_event.run
      end
      Workers.make_pidfile('clockwork', Process.pid)
      Clockwork.run
    end

  end

end
