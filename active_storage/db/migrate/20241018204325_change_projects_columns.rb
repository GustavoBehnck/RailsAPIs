class ChangeProjectsColumns < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :moderation_status, :boolean, default: false
  end
end
