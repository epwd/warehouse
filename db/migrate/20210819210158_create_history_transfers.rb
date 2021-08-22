class CreateHistoryTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :history_transfers do |t|
      t.bigint :src
      t.bigint :dst
      t.text :transferred

      t.timestamps
    end
  end
end
