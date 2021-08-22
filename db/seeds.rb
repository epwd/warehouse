# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.read('koord_russia_.csv').each do |str|
	Region.where( lat: str[3], lng: str[4] ).first_or_create( city: str[0], name: str[1], district: str[2] )
end