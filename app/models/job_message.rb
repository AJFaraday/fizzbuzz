class JobMessage < ActiveRecord::Base

  belongs_to :job

  def formatted_message
    "[#{created_at.strftime('%H:%M:%S')}] #{message}"
  end

end
