class AddIndexToAnimals < ActiveRecord::Migration[5.2]
  def change
    add_index :animals, :outcometype
  end
end
