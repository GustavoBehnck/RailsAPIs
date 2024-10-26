class ChnageColumnsConfigProjects < ActiveRecord::Migration[7.2]
  def change
    change_column :projects, :blocked, :boolean, null: false, default: false
  end
end
