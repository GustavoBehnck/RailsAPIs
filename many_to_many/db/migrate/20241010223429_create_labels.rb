class CreateLabels < ActiveRecord::Migration[7.2]
  def change
    create_table :labels do |t|
      t.text :name

      t.timestamps
    end
  end
end
