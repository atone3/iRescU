# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
CSV.foreach(Rails.root.join('lib/Austin_Animal_Center_Outcomes.csv'), headers: true) do |row|
  
  Animal.create({
    name: row[0],
    birthday: row[1],
    outcometype: row[2],
    outcomesubtype: row[3],
    animaltype: row[4],
    sex: row[5],
    breed: row[6],
    color: row[7]
  })
end