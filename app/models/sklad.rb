class Sklad < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :sklad_products
  has_many :products, through: :sklad_products

  def product_quantify product_id
    product = self.sklad_products.find { |tmp| tmp.product.id == product_id }
    product.nil? ? 0 : product.quantify
  end

  def product_get product_id, quantify
    sklad_product = self.sklad_products.find_by( product_id: product_id )
    if sklad_product.nil?
      errors.add( "quantify", "Product not found" )
    else
      if sklad_product.quantify >= quantify and quantify > 0
        sklad_product.decrement('quantify', quantify)
        sklad_product.quantify <= 0 ? sklad_product.destroy! : sklad_product.save!
      else
        errors.add( "quantify", "Quantify out of stock" )
      end
    end
  end

  def product_add product_id, quantify
    sklad_product = self.sklad_products.find_by( product_id: product_id )

    if sklad_product
      sklad_product.increment!('quantify', quantify)
    else
      sklad_product = SkladProduct.new( sklad_id: self.id, product_id: product_id, quantify: quantify )
      errors.add( "quantify", "Quantify add error" ) unless sklad_product.save!
    end
  end
end
