class CreateLabelsProjectsJoinTable < ActiveRecord::Migration[7.2]
  def change
    create_join_table :labels, :projects
  end
end
