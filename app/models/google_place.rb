class GooglePlace < ApplicationRecord
  def result
    return unless self.place_id
    res = Giv::GooglePlace.new self.place_id
    return unless res && res.status == "OK"
    res
  end


end