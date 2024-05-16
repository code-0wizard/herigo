class AddImagePathToHeritages < ActiveRecord::Migration[7.1]
  def change
    add_column :heritages, :image_path, :string
  end
end
