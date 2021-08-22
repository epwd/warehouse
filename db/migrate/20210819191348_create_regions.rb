class CreateRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :regions do |t|
      t.string :city
      t.string :name
      t.string :district
      t.float :lat
      t.float :lng
    end
  end
end
