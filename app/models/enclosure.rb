class Enclosure < ApplicationRecord
  belongs_to :animal, optional: true
end
