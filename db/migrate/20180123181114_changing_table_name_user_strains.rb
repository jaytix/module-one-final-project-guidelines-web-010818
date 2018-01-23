class ChangingTableNameUserStrains < ActiveRecord::Migration[5.0]
  def change
    rename_table :userstrains, :user_strains
  end
end
