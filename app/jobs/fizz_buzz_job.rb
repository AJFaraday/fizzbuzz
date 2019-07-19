class FizzBuzzJob < ApplicationJob
  queue_as :default

  def perform(options = {})
    options ||= {}
    artificial_step = 0
    fizz_buzzes = options[:fizz_buzz_ids] ? FizzBuzz.where(id: options[:fizz_buzz_ids]) : FizzBuzz.all
    sleep artificial_step
    fizz_buzzes.each do |fizz_buzz|
      log("Checking #{fizz_buzz.name}. fizz_freq: #{fizz_buzz.fizz_frequency} buzz_freq: #{fizz_buzz.buzz_frequency}")
      sleep artificial_step
      fizz_buzz.increment!
      sleep artificial_step
      log("fizz: #{fizz_buzz.fizz} buzz: #{fizz_buzz.buzz}")
      sleep artificial_step
      log(fizz_buzz.result)
    end
  end

end
