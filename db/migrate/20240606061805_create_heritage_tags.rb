class CreateHeritageTags < ActiveRecord::Migration[7.1]
  def change
    create_table :heritage_tags do |t|
      t.references :heritage, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    remove_index :heritage_tags, column: :heritage_id if index_exists?(:heritage_tags, :heritage_id)
    remove_index :heritage_tags, column: :tag_id if index_exists?(:heritage_tags, :tag_id)

    add_index :heritage_tags, [:heritage_id]
    add_index :heritage_tags, [:tag_id]
  end
end
