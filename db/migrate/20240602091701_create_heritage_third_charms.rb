class CreateHeritageThirdCharms < ActiveRecord::Migration[7.1]
  def change
    create_table :heritage_third_charms do |t|
      t.string :main_title
      t.string :sub_title
      t.text :detail
      t.references :heritage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
