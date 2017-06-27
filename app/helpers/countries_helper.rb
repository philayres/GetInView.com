module CountriesHelper

  def country_select_options val=nil
    options_for_select(ISO3166::Country.translations.map{|c| [c.last, c.first]}, val)
  end

  def country_full_name code
    Country.full_name code
  end
end
