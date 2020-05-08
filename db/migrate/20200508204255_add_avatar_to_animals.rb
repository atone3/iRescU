class AddAvatarToAnimals < ActiveRecord::Migration[5.2]
  def change
    add_attachment :animals, :avatar
  end
end
