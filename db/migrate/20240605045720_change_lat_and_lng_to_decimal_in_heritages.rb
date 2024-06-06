class ChangeLatAndLngToDecimalInHeritages < ActiveRecord::Migration[7.1]
  def up
    change_column :heritages, :lat, :decimal, precision: 16, scale: 14
    change_column :heritages, :lng, :decimal, precision: 16, scale: 14
  end

  def down
    change_column :heritages, :lat, :integer
    change_column :heritages, :lng, :integer
  end
end
