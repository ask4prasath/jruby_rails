class CreateRheaConnectors < ActiveRecord::Migration
  def change
    create_table :rhea_connectors do |t|
      t.string :title
      t.string :status
      t.string :created_by

      t.timestamps null: false
    end
  end
end
