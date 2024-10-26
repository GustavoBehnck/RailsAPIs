class ChangeColumnTypeInTableName < ActiveRecord::Migration[7.2]
  def change
    change_column :accounts, :password_digest, :string
  end
end
