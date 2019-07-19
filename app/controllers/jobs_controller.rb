class JobsController < ApplicationController

  #TODO
  def index
    @jobs = Job.order('created_at desc').limit(50)
  end

  def show
    @job = Job.find(params[:id])
  end

  def poll
    job = Job.find(params[:id])
    messages = job.messages(params[:last_message])
    render json: {
      messages: messages,
      time: Time.now.to_s,
      status: job.status,
      last_message: job.job_messages.map(&:order_no).max
    }
  end

end
