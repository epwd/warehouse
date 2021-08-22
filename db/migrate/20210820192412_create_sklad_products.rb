class CreateSkladProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :sklad_products do |t|
      t.references :product, null: false, foreign_key: true
      t.belongs_to :sklad, null: false, foreign_key: true
      t.bigint :quantify

      t.timestamps
    end
  end
end
