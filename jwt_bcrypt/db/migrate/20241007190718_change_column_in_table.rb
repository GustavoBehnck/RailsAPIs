class ChangeColumnInTable < ActiveRecord::Migration[7.2]
  def change
    change_column_null :projects, :name, false
    change_column_null :projects, :txt_body, false
    change_column_null :projects, :keywords, false
    change_column_null :projects, :status, false
    change_column_null :projects, :file_path, false
    change_column_null :projects, :participants, false
    change_column_null :projects, :participants, false
    change_column_default :projects, :blocked, false
    change_column_default :projects, :status, "Em progresso"
  end
end
