class DropHeritageFirstCharms < ActiveRecord::Migration[7.1]
  def change
    drop_table :heritage_first_charms
    drop_table :heritage_second_charms
    drop_table :heritage_third_charms
    drop_table :heritage_fourth_charms
  end
end
