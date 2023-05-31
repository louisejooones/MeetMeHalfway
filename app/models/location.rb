class Location < ApplicationRecord
  belongs_to :meeting

  self.inheritance_column = :location_type
end
