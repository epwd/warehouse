class DropColumnDeliveryLastFromSkladProduct < ActiveRecord::Migration[6.1]
  def down
    remove_column :sklad_products, :delivery_last
  end
  def up
    add_column :sklad_products, :delivery_last, :datetime
  end
end
