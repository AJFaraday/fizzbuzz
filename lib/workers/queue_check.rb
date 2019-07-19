class Workers

  class QueueCheck

    Queue = Struct.new(:name, :size) do
      def summary
        "#{name.ljust(15)}: #{size} jobs"
      end
    end

    def QueueCheck.run(show = true)
      new(show).run
    end

    def initialize(show = true)
      @show = show
    end

    def run
      queues = Sidekiq::Queue.all.map {|q| Workers::QueueCheck::Queue.new(q.name, q.size)}
      queues.each {|q| puts q.summary} if @show
      queues
    end

  end

end
