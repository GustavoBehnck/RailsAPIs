class AddUniqueIndexToAccounts < ActiveRecord::Migration[7.2]
  def change
    add_index :accounts, :email, unique: true
  end
end
