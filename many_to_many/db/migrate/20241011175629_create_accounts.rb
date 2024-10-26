class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.text :email, null: false
      t.string :password_digest, null: false
      t.boolean :admin, default: false, null: false

      t.timestamps
    end

    add_index :accounts, :email, unique: true
  end
end
