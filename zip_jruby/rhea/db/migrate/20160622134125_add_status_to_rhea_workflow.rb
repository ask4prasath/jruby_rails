class AddStatusToRheaWorkflow < ActiveRecord::Migration
  def change
    add_column :rhea_workflows, :status, :string
  end
end
