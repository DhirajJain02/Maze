class CreateSolidQueueJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.jsonb :arguments, default: []
      t.string :job_class
      t.datetime :scheduled_at
      t.datetime :locked_at
      t.timestamps
    end
  end
end
