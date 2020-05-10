class Animal < ApplicationRecord
  belongs_to :enclosure, optional: true
  
  validates :name, presence: true
  validates :birthday, presence: true
  validates :intake_date, presence: true
  validates :outcome_date, presence: true
  validates :outcometype, presence: true
  
  validate :birds_livestock_and_other_cannot_be_active
  validate :intake_date_must_be_before_or_equal_to_today
  validate :birthday_must_be_before_or_equal_to_today
  validate :outcome_date_must_be_before_or_equal_to_today
  validate :outcome_date_must_be_after_or_equal_to_intake_date
  
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
    
    def birds_livestock_and_other_cannot_be_active
      return unless outcometype == "Active"
      errors.add(:outcometype, "cannot be active for an animal of type Bird, Livestock, or Other") unless (animaltype == "Dog" or animaltype == "Cat")
    end
  
    def intake_date_must_be_on_or_after_birthday
      return unless intake_date and birthday
      errors.add(:intake_date, "must be on or after the animal's birthday") unless intake_date >= birthday
    end
    
    def outcome_date_must_be_on_or_after_birthday
      return unless outcome_date and birthday
      errors.add(:outcome_date, "must be on or after the animal's birthday") unless outcome_date >= birthday
    end
    
    def intake_date_must_be_before_or_equal_to_today
      return unless intake_date
      errors.add(:intake_date, "cannot be later than today") unless intake_date <= Date.today
    end
    
    def birthday_must_be_before_or_equal_to_today
      return unless birthday
      errors.add(:birthday, "cannot be later than today") unless birthday <= Date.today
    end
    
    def outcome_date_must_be_before_or_equal_to_today
      return unless outcome_date
      errors.add(:outcome_date, "cannot be later than today") unless outcome_date <= Date.today
    end
    
    def outcome_date_must_be_after_or_equal_to_intake_date
      return unless outcome_date and intake_date
      errors.add(:outcome_date, "cannot be earlier than intake date") unless outcome_date >= intake_date
    end
    
end
