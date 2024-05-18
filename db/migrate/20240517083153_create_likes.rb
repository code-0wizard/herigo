class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.integer :review_id
      t.integer :user_id

      t.timestamps
    end
    add_index :likes, :review_id
    add_index :likes, :user_id
    add_index :likes, [:user_id, :review_id], unique: true
  end
end
