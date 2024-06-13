class AddOrderToHeritageCharms < ActiveRecord::Migration[7.1]
  def change
    add_column :heritage_charms, :order, :integer
  end
end
