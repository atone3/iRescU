class Animal < ApplicationRecord
  belongs_to :enclosure, optional: true
  
  validates :name, presence: true
  validates :intake_date, presence: true
  
  # TODO: birthday < intakeDate;
  # Status: Active, Inactive
  # Status determined by outcomeDate
  
  
end
