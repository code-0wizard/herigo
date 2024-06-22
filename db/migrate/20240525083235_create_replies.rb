class CreateReplies < ActiveRecord::Migration[7.1]
  def change
    create_table :replies do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
    add_index :replies, %i[user_id created_at]
    add_index :replies, %i[review_id created_at]
  end
end
