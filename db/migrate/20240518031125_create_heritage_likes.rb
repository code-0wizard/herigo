class CreateHeritageLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :heritage_likes do |t|
      t.integer :user_id
      t.integer :heritage_id

      t.timestamps
    end
    add_index :heritage_likes, :user_id
    add_index :heritage_likes, :heritage_id
    add_index :heritage_likes, %i[user_id heritage_id], unique: true
  end
end
