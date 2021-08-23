module TransfersHelper
  def products_quantify element
    product_iq, quantify = element.split('-')
    "#{Product.find(product_iq).name} - #{quantify} #{t('ed')}"
  end
end
