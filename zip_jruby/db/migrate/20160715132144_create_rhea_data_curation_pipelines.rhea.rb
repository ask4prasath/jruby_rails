# This migration comes from rhea (originally 20160619125103)
class CreateRheaDataCurationPipelines < ActiveRecord::Migration
  def change
    create_table :rhea_data_curation_pipelines do |t|
      t.string :name
      t.string :file_type
      t.string :parent
      t.string :hdfs_path
      t.string :file_attributes, :limit => 6000
      t.string :regex
      t.string :schedule
      t.integer :dataset_id
      t.integer :workflow_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
