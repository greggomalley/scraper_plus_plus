class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.text :name
      t.text :cron
      t.timestamps
    end
  end
end
