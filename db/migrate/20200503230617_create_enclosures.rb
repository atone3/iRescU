class CreateEnclosures < ActiveRecord::Migration[5.2]
  def change
    create_table :enclosures do |t|
      t.string :name

      t.timestamps
    end
  end
end
