class Workers

  class StatusCheck

    def StatusCheck.run(show = true)
      new(show).run
    end

    def initialize(show = true)
      @show = true
    end

    def run
      summaries = Workers.pids.map{|pid| RunningProcess.new(pid).summary}
      summaries.each{|process| puts process} if @show
      summaries
    end

  end

end
