class MudarAccountsNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null(:accounts, :name, false)
    change_column_null(:accounts, :email, false)
    change_column_null(:accounts, :password, false)
    change_column_null(:accounts, :phone, false)
    change_column_default(:accounts, :archived, false)
  end
end
