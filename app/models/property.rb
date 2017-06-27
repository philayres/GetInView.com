class Property < ApplicationRecord

  has_one :property_address
  has_one :property_contact_details
  has_one :google_place
  has_one :property_description
  
  default_scope {where(hidden: false)}
  
  
  PropertyTypes = {
    aparthotel: "ApartHotel",
    apartment: "Apartment",
    bnb: "Bed & Breakfast",
    campground: "Campground",
    guesthouse: "Guesthouse",
    homestay: "Home Stay",
    hostel: "Hostel",
    hotel: "Hotel",
    motel: "Motel"
 }
  
  def claimed?
    claim_status.to_s=="claimed"
  end
  
  def property_type_caption
    pt = self.property_type
    return "" unless pt
    return PropertyTypes[pt.to_sym] || ""
  end
  
end
