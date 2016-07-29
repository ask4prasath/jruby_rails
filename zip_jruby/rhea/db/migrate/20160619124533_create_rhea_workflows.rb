class CreateRheaWorkflows < ActiveRecord::Migration
  def change
    create_table :rhea_workflows do |t|
      t.string :name
      t.string :created_by
      t.string :schedule
      t.string :status
      t.string :notification_emails
      t.timestamps null: false
    end
  end
end
