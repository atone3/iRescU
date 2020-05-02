class Animal < ApplicationRecord
  
  validates :name, presence: true
  validates :intake_date, presence: true
  
  # TODO: birthday < intakeDate;
  # Status: Active, Inactive
  # Status determined by outcomeDate
  
  
end
