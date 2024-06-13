class AddEmailResetToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email_reset_digest, :string
    add_column :users, :email_reset_sent_at, :datetime
  end
end
