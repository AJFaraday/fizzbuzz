class Job < ActiveRecord::Base

  has_many :job_messages

  serialize :args

  PENDING = 'pending'
  RUNNING = 'running'
  FINISHED = 'finished'
  ERROR = 'error'

  def messages(last_message=nil)
    job_messages.reload
    if last_message
      job_messages.where("order_no > #{last_message}").order(:order_no).map(&:formatted_message)
    else
      job_messages.order(:order_no).map(&:formatted_message)
    end
  end

  def add_message(msg)
    @order_no ||= job_messages.map(&:order_no).max || 0
    job_messages.create(message: msg, order_no: @order_no += 1)
  end

end
