class ChangeColumnToNotNullNameLabels < ActiveRecord::Migration[7.2]
  def change
    change_column_null :labels, :name, false
  end
end
