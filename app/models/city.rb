class City < ApplicationRecord
  belongs_to :state
  default_scope {order :name}
end
