class AddBlockColumnAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :accounts, :blocked, :boolean, default: false, null: false
  end
end
