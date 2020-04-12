class Animal < ApplicationRecord
  
  validates :name, presence: true
  
  # TODO: birthday < intakeDate;
  # Status: Active, Inactive
  # Status determined by outcomeDate
  
end
