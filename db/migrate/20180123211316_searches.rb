class Searches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :type
    end
  end
end
