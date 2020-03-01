class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.text :name
      t.text :birthday
      t.text :outcometype
      t.text :outcomesubtype
      t.text :animaltype
      t.text :sex
      t.text :breed
      t.text :color

      t.timestamps
    end
  end
end
