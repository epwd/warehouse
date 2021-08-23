class AddProductsToTransfer < ActiveRecord::Migration[6.1]
  def change
    add_column :transfers, :products, :text
  end
end
