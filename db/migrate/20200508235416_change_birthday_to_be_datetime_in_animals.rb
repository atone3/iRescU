class ChangeBirthdayToBeDatetimeInAnimals < ActiveRecord::Migration[5.2]
  def change
    change_column :animals, :birthday, :datetime
  end
end
