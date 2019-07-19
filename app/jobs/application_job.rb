class ApplicationJob < ActiveJob::Base

  before_enqueue :init_job
  around_perform :wrap_job

  def job
    @job ||= ::Job.where(active_job_id: job_id).first
  end

  private

  def wrap_job
    set_logger
    job.update_attribute(:status, ::Job::RUNNING)
    log("Started at #{Time.now}")
    yield
    log("Ended at #{Time.now}")
    job.update_attribute(:status, ::Job::FINISHED)
  rescue => er
    job.update_attribute(:status, ::Job::ERROR)
    log(er.message)
    log(er.backtrace.join("\n"))
  end

  def set_logger
    self.logger = Logger.new(File.join(Rails.root, 'log', "#{self.class.to_s.underscore}.log"))
  end

  def init_job
    @job = ::Job.create!(
      job_class: self.class.to_s,
      active_job_id: job_id,
      args: arguments
    )
  end

  def log(msg)
    self.logger.info(msg)
    puts(msg)
    job.add_message(msg) if job
  end

end
