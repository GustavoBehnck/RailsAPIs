class ChangeColumnNotNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :accounts, :password_digest, false
  end
end
