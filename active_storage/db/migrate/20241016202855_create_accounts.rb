class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.text :name
      t.text :email
      t.string :password_digest
      t.text :phone
      t.boolean :blocked
      t.boolean :admin

      t.timestamps
    end
  end
end
