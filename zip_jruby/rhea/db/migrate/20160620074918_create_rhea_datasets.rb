class CreateRheaDatasets < ActiveRecord::Migration
  def change
    create_table :rhea_datasets do |t|
      t.string :name
      t.text :schema_key, :limit => 650000
      t.text :schema_value, :limit => 650000
      t.string :status
      t.string :created_by
      t.integer :workflow_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
