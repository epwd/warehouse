class CreateSklads < ActiveRecord::Migration[6.1]
  def change
    create_table :sklads do |t|
      t.string :name
      t.datetime :delivery_last
      t.belongs_to :region

      t.timestamps
    end
  end
end
