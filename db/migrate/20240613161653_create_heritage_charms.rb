class CreateHeritageCharms < ActiveRecord::Migration[7.1]
  def change
    create_table :heritage_charms do |t|
      t.string :title
      t.text :description
      t.references :heritage, null: false, foreign_key: true
      t.timestamps
    end
  end
end
