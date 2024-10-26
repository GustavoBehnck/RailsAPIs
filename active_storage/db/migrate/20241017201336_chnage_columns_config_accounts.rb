class ChnageColumnsConfigAccounts < ActiveRecord::Migration[7.2]
  def change
    change_column :accounts, :blocked, :boolean, null: false, default: false
    change_column :accounts, :admin, :boolean, null: false, default: false
    add_index :accounts, :email, unique: true
  end
end
