class FizzBuzzsController < ApplicationController
  before_action :set_fizz_buzz, only: [:show, :edit, :update, :destroy, :increment]

  def index
    @fizz_buzzs = FizzBuzz.all
  end

  def show
  end

  def new
    @fizz_buzz = FizzBuzz.new
  end

  def edit
  end

  def create
    @fizz_buzz = FizzBuzz.new(fizz_buzz_params)

    respond_to do |format|
      if @fizz_buzz.save
        format.html { redirect_to @fizz_buzz, notice: 'Fizz buzz was successfully created.' }
        format.json { render :show, status: :created, location: @fizz_buzz }
      else
        format.html { render :new }
        format.json { render json: @fizz_buzz.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @fizz_buzz.update(fizz_buzz_params)
        format.html { redirect_to @fizz_buzz, notice: 'Fizz buzz was successfully updated.' }
        format.json { render :show, status: :ok, location: @fizz_buzz }
      else
        format.html { render :edit }
        format.json { render json: @fizz_buzz.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fizz_buzz.destroy
    respond_to do |format|
      format.html { redirect_to fizz_buzzs_url, notice: 'Fizz buzz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def increment
    process = FizzBuzzJob.perform_later(fizz_buzz_ids: [@fizz_buzz.id])
    redirect_to(job_path(process.job))
  end

  def increment_all
    process = FizzBuzzJob.perform_later()
    redirect_to(job_path(process.job))
  end
  
  def generate
    fizz_buzz = FizzBuzz.generate
    redirect_to fizz_buzz_path(fizz_buzz)
  end

  private
    def set_fizz_buzz
      @fizz_buzz = FizzBuzz.find(params[:id])
    end

    def fizz_buzz_params
      params.require(:fizz_buzz).permit(:name, :fizz, :buzz, :fizz_frequency, :integer, :buzz_frequency)
    end
end
