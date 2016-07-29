class AddVersionToRheaWorkflow < ActiveRecord::Migration
  def change
    add_column :rhea_workflows, :version, :integer
  end
end
