class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.text :name
      t.date :date_proj_started
      t.text :txt_body
      t.boolean :blocked
      t.references :account, null: false, foreign_key: true
      t.json :participants
      t.text :status
      t.text :file_path
      t.text :keywords

      t.timestamps
    end
  end
end
