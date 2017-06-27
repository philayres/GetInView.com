class PropertyContactDetails < ApplicationRecord


  def primary_phone_url
    "tel:+" + "#{primary_phone_country}#{primary_phone}".gsub(/[^0-9]/, "")
  end
  
  def secondary_phone_url
    "tel:+" + "#{secondary_phone_country}#{secondary_phone}".gsub(/[^0-9]/, "")
  end
end