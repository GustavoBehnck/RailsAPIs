class CreateAccountsProjectsJoinTable < ActiveRecord::Migration[7.2]
  def change
    create_join_table :accounts, :projects
  end
end
