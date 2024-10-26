class DeleteColumnProjects < ActiveRecord::Migration[7.2]
  def change
    remove_column :projects, :article, :string
  end
end
