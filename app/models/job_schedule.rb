class JobSchedule < ActiveRecord::Base

  serialize :parameters

  def self.generate
    #if JobSchedule.count == 0
      JobSchedule.create!(
        name: '1 minute FizzBuzz',
        frequency_value: 1,
        frequency_unit: 'minute',
        class_name: 'FizzBuzzJob',
        queue_name: 'default',
        parameters: {}
      )
    #end
  end

  def run
    class_name.constantize.perform_later(parameters)
  end

  def frequency
    frequency_value.to_f.send(frequency_unit.to_s.pluralize)
  end

end

