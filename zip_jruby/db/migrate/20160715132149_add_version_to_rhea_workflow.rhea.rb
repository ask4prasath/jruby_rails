# This migration comes from rhea (originally 20160622092005)
class AddVersionToRheaWorkflow < ActiveRecord::Migration
  def change
    add_column :rhea_workflows, :version, :integer
  end
end
