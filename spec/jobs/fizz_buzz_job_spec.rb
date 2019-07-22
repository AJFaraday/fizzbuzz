require_relative ('../spec_helper.rb')

describe FizzBuzzJob do

  before(:each) do
    @fizz_buzz = FizzBuzz.generate
  end

  it 'truth should be truthy' do
    expect(true).to be_truthy
  end

  it 'should run the job inline' do
    expect {
      FizzBuzzJob.perform_later
    }.to change{@fizz_buzz.reload.fizz}.by(1)
  end

  it 'should build a Job object' do
    process = FizzBuzzJob.perform_later
    expect(process.job).to be_a(Job)
  end

end
