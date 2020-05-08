class Animal < ApplicationRecord
  belongs_to :enclosure, optional: true
  
  validates :name, presence: true
  validates :intake_date, presence: true
  validates :outcometype, presence: true
  
  # TODO: birthday < intakeDate;
  # Status: Active, Inactive
  # Status determined by outcomeDate
  
  has_attached_file :avatar
  
  # validate the attached image is jpg/png/etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
end
