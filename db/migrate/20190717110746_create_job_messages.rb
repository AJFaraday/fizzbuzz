class CreateJobMessages < ActiveRecord::Migration
  def change
    create_table :job_messages do |t|
      t.string :job_id
      t.string :integer
      t.string :message
      t.integer :order_no

      t.timestamps null: false
    end
  end
end
