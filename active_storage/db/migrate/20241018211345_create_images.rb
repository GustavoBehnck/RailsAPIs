class CreateImages < ActiveRecord::Migration[7.2]
  def change
    create_table :images do |t|
      t.binary :image
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
