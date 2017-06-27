class PropertyAddress < ApplicationRecord
  

  def valid_gps?
    latitude && longitude
  end

  def as_single_line
       "#{self.address1}, #{self.address2 + ', ' if self.address2}#{self.city}, #{self.state}, #{Country.full_name self.country}"
       
  end

end