class AddUniqueIndexToHeritageIdInHeritageSecondCharms < ActiveRecord::Migration[7.1]
  def change
    remove_index :heritage_second_charms, :heritage_id
    add_index :heritage_second_charms, :heritage_id, unique: true
  end
end
