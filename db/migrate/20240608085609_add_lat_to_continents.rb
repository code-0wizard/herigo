class AddLatToContinents < ActiveRecord::Migration[7.1]
  def change
    add_column :continents, :lat, :decimal, precision: 16, scale: 14
    add_column :continents, :lng, :decimal, precision: 16, scale: 14
  end
end
