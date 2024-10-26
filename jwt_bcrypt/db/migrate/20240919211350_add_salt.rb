class AddSalt < ActiveRecord::Migration[7.2]
  def change
    add_column(:accounts, :pass_salt, :string, null: false, default: "d2f1f9l8t")
  end
end
