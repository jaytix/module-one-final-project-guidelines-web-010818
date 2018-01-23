class UserSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :user_searches do |t|
      t.integer :search_id
      t.integer :user_id
    end
  end
end
