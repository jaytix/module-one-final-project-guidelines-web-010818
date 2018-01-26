class UserStrains < ActiveRecord::Migration[5.0]
  def change
    create_table :user_strains do |t|
      t.integer :user_id
      t.integer :strain_id
    end
  end
end
