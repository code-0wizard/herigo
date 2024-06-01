class AddContinentIdToCountries < ActiveRecord::Migration[7.1]
  def change
    add_column :countries, :continent_id, :integer
    add_foreign_key :countries, :continents
    add_index :countries, :continent_id
  end
end
