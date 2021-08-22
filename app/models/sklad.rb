class Sklad < ApplicationRecord
	validates :name, uniqueness: true, presence: true

	has_many :products, through: :sklad_products
end
