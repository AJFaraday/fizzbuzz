class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :job_class
      t.string :active_job_id
      t.string :status, default: 'pending'
      t.text :args

      t.timestamps null: false
    end
  end
end
