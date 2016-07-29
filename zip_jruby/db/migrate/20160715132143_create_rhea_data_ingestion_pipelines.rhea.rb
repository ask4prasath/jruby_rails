# This migration comes from rhea (originally 20160619124754)
class CreateRheaDataIngestionPipelines < ActiveRecord::Migration
  def change
    create_table :rhea_data_ingestion_pipelines do |t|
      t.string :name
      t.string :connector_type
      t.string :credentials, :limit => 3000
      t.string :sink_path
      t.string :schedule
      t.integer :workflow_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
