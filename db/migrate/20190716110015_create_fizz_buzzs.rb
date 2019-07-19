class CreateFizzBuzzs < ActiveRecord::Migration
  def change
    create_table :fizz_buzzs do |t|
      t.string :name
      t.integer :fizz
      t.integer :fizz_frequency
      t.integer :buzz
      t.integer :buzz_frequency

      t.timestamps null: false
    end
  end
end
