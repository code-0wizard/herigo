class RemoveImagePathFromHeritages < ActiveRecord::Migration[7.1]
  def change
    remove_column :heritages, :image_path, :string
  end
end
