class Animal < ApplicationRecord
  belongs_to :enclosure, optional: true
  
  validates :name, presence: true
  validates :birthday, presence: true
  validates :intake_date, presence: true
  validates :outcometype, presence: true
  
  validate :intake_date_must_be_before_or_equal_to_today
  validate :intake_date_must_be_on_or_after_birthday
  validate :animal_must_have_a_location
  
  
  # TODO: intakeDate <= Today
  # Status: Active, Inactive
  # Status determined by outcomeDate
  
  has_attached_file :avatar
  
  # validate the attached image is jpg/png/etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  private 
    def animal_must_have_a_location
      return unless outcometype == "Active"
      errors.add(:enclosure_id, "must be selected for active animals") unless enclosure_id.present?
    end
  
    def intake_date_must_be_on_or_after_birthday
      return unless intake_date and birthday
      errors.add(:intake_date, "must be on or after the animal's birthday") unless intake_date >= birthday
    end
    
    def intake_date_must_be_before_or_equal_to_today
      return unless intake_date
      errors.add(:intake_date, "cannot be later than today") unless intake_date <= Date.today
    end
     
end
