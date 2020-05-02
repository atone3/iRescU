class AddIntakeDateToAnimals < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :intake_date, :datetime
  end
end
