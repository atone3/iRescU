class ChangeBirthdayToBeDatetimeInAnimals < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :birthday, :datetime
  end
end
