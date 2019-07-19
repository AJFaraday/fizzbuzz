class Workers

  class Halter < Workers::RunningProcess

    def self.stop(pid)
      new(pid).stop
    end

    def stop
      if process_active?
        puts "Stopping #{pid} pid #{info["State"]} #{info["CmdLine"]}  memory #{info["VmSize"]} (Peak #{info["VmPeak"]})"
        Process.kill('HUP', pid.to_i)
        sleep(1)
        if process_active?
          Process.kill('KILL', pid.to_i)
          sleep(1)
        end
        delete_pidfile unless process_active?
      else
        puts "Process #{pid} has already stopped."
        delete_pidfile
      end
    end

    private

    def delete_pidfile
      file = Workers.pidfiles.detect {|x| x.include?(pid.to_s)}
      if file
        puts "Deleting #{file}"
        File.delete(file)
      else
        puts "Could not find pidfile for #{pid}"
      end
    end

  end

end
