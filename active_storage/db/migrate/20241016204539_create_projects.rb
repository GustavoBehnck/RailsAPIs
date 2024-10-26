class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.text :title
      t.date :date_created
      t.text :body
      t.integer :status
      t.string :article
      t.boolean :blocked
      t.json :participants

      t.timestamps
    end
  end
end
