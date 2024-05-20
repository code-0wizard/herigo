class AddContentToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :content, :string
  end
end
