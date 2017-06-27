FactoryGirl.define do
  
  

  factory :property_address do
    address1 'somewhere'
    city 'London'
    state 'Greater London'
    postal_code 'EC1W 2RA'
    country 'GB'
    latitude '51.00000'
    longitude '0.1000'

  end

  factory :property do
    property_address
    name 'Hotel DeLuxe'
    property_type  'hotel'
    hidden false
  end
  

end