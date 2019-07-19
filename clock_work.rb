require './config/boot'
require './config/environment'
require 'clockwork/database_events'

module Clockwork
  # required to enable database syncing support
  Clockwork.manager = DatabaseEvents::Manager.new

  sync_database_events(model: JobSchedule, every: 30.second) do |job_schedule|
    job_schedule.run
  end
end
