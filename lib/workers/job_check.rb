class Workers

  class JobCheck

    Job = Struct.new(:queue, :started_at, :job_class, :arguments) do
      def summary
        <<TEXT
#{job_class}
  Started at: #{started_at}  
  On Queue: #{queue}
  Arguments: #{arguments}
TEXT
      end
    end

    def JobCheck.run(show = true)
      new(show).run
    end

    def initialize(show = true)
      @show = show
    end

    def run
      jobs = Sidekiq::Workers.new.map do |process_id, thread_id, worker|
        Workers::JobCheck::Job.new(
          worker['queue'],
          Time.at(worker['run_at']),
          worker['payload']['wrapped'],
          worker['payload']['args'][0]['arguments'].inspect
        )
      end
      jobs.each {|j| puts j.summary} if @show
      jobs
    end

  end

end
