class Strains < ActiveRecord::Migration[5.0]
  def change
    create_table :strains do |t|
      t.string :name
      t.string :race
      t.string :medical
      t.string :positive_effects
      t.string :flavors
    end
  end
end
