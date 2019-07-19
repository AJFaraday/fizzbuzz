class Workers

  class Launcher

    attr_reader :name, :block

    def self.run(name, &block)
      Launcher.new(name, block).start
    end

    def initialize(name, block)
      @name = name
      @block = block
    end

    def start
      ActiveRecord::Base.connection.disconnect!
      ActiveRecord::Base.establish_connection
      spawnling = Spawnling.new(
        argv: "spawnling_#{name}",
        kill:true,
        method: :fork,
        detach: true
      ) do
        block.call
      end
      make_pidfile(spawnling.handle)
    end

    private

    def make_pidfile(pid)
      Workers.make_pidfile(name, pid)
    end

  end
end
