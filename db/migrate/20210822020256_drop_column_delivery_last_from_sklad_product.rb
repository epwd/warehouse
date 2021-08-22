class DropColumnDeliveryLastFromSkladProduct < ActiveRecord::Migration[6.1]
  def change
    remove_column :sklad_products, :delivery_last
  end
end
