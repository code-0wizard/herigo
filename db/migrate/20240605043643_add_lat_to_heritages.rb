class AddLatToHeritages < ActiveRecord::Migration[7.1]
  def change
    add_column :heritages, :lat, :integer
    add_column :heritages, :lng, :integer
  end
end
