class Userstrains < ActiveRecord::Migration[5.0]
  def change
    create_table :userstrains do |t|
      t.integer :user_id
      t.integer :strain_id
    end
  end
end
