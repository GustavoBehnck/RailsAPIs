class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.text :name
      t.text :body
      t.json :participants

      t.timestamps
    end
  end
end
