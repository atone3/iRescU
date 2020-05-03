# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'faker'

CSV.foreach(Rails.root.join('lib/Austin_Animal_Center_Outcomes.csv'), headers: true) do |row|
  
  name = row[0]
  birthday = row[1].insert(-3, '20')
  
  if (name.blank? || name.nil? || name.include?("0") || name.include?("1") || name.include?("2") || name.include?("3") || name.include?("4") || name.include?("5") || name.include?("6") || name.include?("7") || name.include?("8") || name.include?("9"))
    if (row[4].downcase == 'cat')
      name = Faker::Creature::Cat.name
    elsif (row[4].downcase == 'dog')
      name = Faker::Creature::Dog.name
    elsif (row[5].downcase.include? "female")
      name = Faker::Name.female_first_name
    else 
      name = Faker::Name.male_first_name 
    end
  end
  
  intake_date = Faker::Date.between(from: Date.strptime(birthday, '%m/%d/%Y'), to: 10.days.ago)
  outcome_date = Faker::Date.between(from: intake_date, to: 1.day.ago)
  
  Animal.create(
    :name =>  name,
    :birthday => birthday,
    :outcometype => row[2],
    :outcomesubtype => row[3],
    :animaltype => row[4],
    :sex => row[5],
    :breed => row[6],
    :color => row[7],
    :intake_date => intake_date,
    :outcome_date => outcome_date
  )

end