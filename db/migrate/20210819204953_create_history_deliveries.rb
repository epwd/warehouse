class CreateHistoryDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :history_deliveries do |t|
      t.text :delivered

      t.timestamps
    end
  end
end
