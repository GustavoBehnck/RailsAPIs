class AddUniqueIndexToLabels < ActiveRecord::Migration[7.2]
  def change
    add_index :labels, :name, unique: true
  end
end
