class SkladProduct < ApplicationRecord
  belongs_to :product
  belongs_to :sklad
end
