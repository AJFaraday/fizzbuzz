class FizzBuzz < ActiveRecord::Base

  def self.generate(name = nil, fizz_freq = nil, buzz_freq = nil)
    name ||= FizzBuzz.maximum(:name)
    name ||= 'fizzbuzz-001'
    name.succ! while FizzBuzz.where(name: name).exists?

    fizz_freq ||= rand(5) + 1
    buzz_freq ||= rand(5) + 1
    self.create!(
      name: name,
      fizz: 0,
      buzz: 0,
      fizz_frequency: fizz_freq,
      buzz_frequency: buzz_freq
    )
  end

  def increment!
    self.fizz += 1
    self.buzz += 1
    save!
  end

  def should_fizz?
    (self.fizz % self.fizz_frequency) == 0
  end

  def should_buzz?
    (self.buzz % self.buzz_frequency) == 0
  end

  def result
    "#{'fizz' if should_fizz?}#{'buzz' if should_buzz?}"
  end

end
