class ChangeImageColumnImages < ActiveRecord::Migration[7.2]
  def change
    change_column :images, :image, :text
  end
end
