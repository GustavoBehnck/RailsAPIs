class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.text :name
      t.text :email
      t.text :password
      t.text :phone
      t.boolean :archived

      t.timestamps
    end
  end
end
