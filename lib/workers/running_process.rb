class Workers

  class RunningProcess

    attr_reader :pid

    def initialize(pid)
      @pid = pid
    end

    def summary
      "#{pid} pid #{info["State"]} #{info["CmdLine"].strip}  memory #{info["VmSize"]} (Peak #{info["VmPeak"]})"
    end

    def info
      rows = CSV.read(File.open("/proc/#{pid}/status"), {:headers => true, :col_sep => "\t", :encoding => 'UTF-8'})
      hash = Hash[rows.collect {|r| [r["Name:"].to_s.gsub(/:/, ''), r["ruby"].to_s.strip]}]
      hash["CmdLine"] = File.open("/proc/#{pid}/cmdline", "r") {|f| f.read}.to_s
      hash
    rescue => ex
      {"State" => "Error #{ex.message}"}
    end

    def process_active?
      File.exists?("/proc/#{pid}/status")
    end

  end

end
