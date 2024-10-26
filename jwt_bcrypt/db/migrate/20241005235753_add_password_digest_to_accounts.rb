class AddPasswordDigestToAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :accounts, :password_digest, :text
    remove_column :accounts, :password, :text
    remove_column :accounts, :pass_salt, :text
  end
end
