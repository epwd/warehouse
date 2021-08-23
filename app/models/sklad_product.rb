class SkladProduct < ApplicationRecord
  belongs_to :product
  belongs_to :sklad
  
  # delegate :name, to: :product # if get only name of product 
end
