class Workers

  class SidekiqLauncher

    attr_reader :name, :config

    def SidekiqLauncher.run_all
      configurations = YAML.load_file(File.join(Rails.root, 'config', 'workers.yml'))
      configurations.each do |name, config|
        SidekiqLauncher.run(name, config)
      end
    end

    def SidekiqLauncher.run(name, config)
      SidekiqLauncher.new(name, config).run
    end

    def initialize(name, config)
      @name = name
      @config = config
    end

    def run
      puts "Starting Sidekiq with configuration '#{name}'"
      cli = Sidekiq::CLI.instance
      args = [
        '-e', 'production',
        # Logs deprecated. Find out if it has useful info; if so replace, if not remove
        '-L', "#{Rails.root}/log/sidekiq_#{name}.log",
        '-c', config['concurrency'].to_s
      ]
      config['queues'].each do |queue|
        args << '-q'
        args << queue
      end
      puts "`sidekiq #{args.join(' ')}`"
      cli.parse(args)
      Launcher.run(name) {cli.run}
    end

  end

end
