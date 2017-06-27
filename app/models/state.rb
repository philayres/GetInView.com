class State < ApplicationRecord
  belongs_to :country
  has_many :cities
  default_scope {order :name}
end
