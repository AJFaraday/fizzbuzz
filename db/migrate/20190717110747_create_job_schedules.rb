class CreateJobSchedules < ActiveRecord::Migration
  def change
    create_table :job_schedules do |t|
      t.string :name
      t.integer :frequency_value
      t.string :frequency_unit
      t.string :at
      t.string :class_name
      t.string :queue_name
      t.text :parameters

      t.timestamps null: false
    end
  end
end
