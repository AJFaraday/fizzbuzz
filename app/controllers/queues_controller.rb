class QueuesController < ApplicationController

  def index
    @queues = Sidekiq::Queue.all
  end

  def show
    @queue = Sidekiq::Queue.new(params[:id])
  end

end

