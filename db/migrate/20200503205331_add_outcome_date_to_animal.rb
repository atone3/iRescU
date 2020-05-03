class AddOutcomeDateToAnimal < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :outcome_date, :datetime
  end
end
