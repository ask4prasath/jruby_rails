class CreateRheaAggregations < ActiveRecord::Migration
  def change
    create_table :rhea_aggregations do |t|
      t.string :name
      t.string :aggregation_type
      t.string :file_path
      t.text :query, :limit => 650000
      t.string :status
      t.string :schedule
      t.integer :workflow_id, index: true, foreign_key: true
      t.string :correlation_ids

      t.timestamps null: false
    end
  end
end
