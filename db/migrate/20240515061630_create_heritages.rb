class CreateHeritages < ActiveRecord::Migration[7.1]
  def change
    create_table :heritages do |t|
      t.string :name
      t.text :content
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
