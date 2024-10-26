class CreateKeywords < ActiveRecord::Migration[7.2]
  def change
    create_table :keywords do |t|
      t.text :description
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end