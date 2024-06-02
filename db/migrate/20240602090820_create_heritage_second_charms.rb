class CreateHeritageSecondCharms < ActiveRecord::Migration[7.1]
  def change
    create_table :heritage_second_charms do |t|
      t.string :main_title
      t.string :sub_title
      t.text :detail
      t.references :heritage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
