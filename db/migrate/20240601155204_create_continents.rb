class CreateContinents < ActiveRecord::Migration[7.1]
  def change
    create_table :continents do |t|
      t.string :name

      t.timestamps
    end
  end
end
