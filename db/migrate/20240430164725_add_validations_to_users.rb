class AddValidationsToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :name, :string, null: false, limit: 20
    change_column :users, :email, :string, null: false
    add_index :users, :email, unique: true
    change_column :users, :password_digest, :string, null: false
  end
end
