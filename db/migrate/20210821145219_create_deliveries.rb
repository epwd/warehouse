class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.datetime :date_time
      t.references :product, null: false, foreign_key: true
      t.belongs_to :sklad, null: false, foreign_key: true
      t.bigint :quantify
      t.string :aasm_state

      t.timestamps
    end
  end
end
