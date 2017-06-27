class Country < ApplicationRecord
  has_many :states
  default_scope {order :name} 
  def full_name in_lang=nil
    ISO3166::Country.translations[self.name]
  end
  
  def self.full_name code, in_lang=nil
    ISO3166::Country.translations[code]
  end
end
