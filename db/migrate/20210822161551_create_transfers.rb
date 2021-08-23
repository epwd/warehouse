class CreateTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :transfers do |t|
      t.references :product, null: true, foreign_key: true
      t.bigint :src_sklad
      t.bigint :dst_sklad
      t.bigint :quantify

      t.timestamps
    end
  end
end
