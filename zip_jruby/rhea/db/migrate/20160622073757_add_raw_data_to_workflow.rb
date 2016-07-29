class AddRawDataToWorkflow < ActiveRecord::Migration
  def change
    add_column :rhea_workflows, :raw_data, :string
  end
end
