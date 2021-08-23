class MakeDeliveryWorker
  include Sidekiq::Worker

  def perform(delivery_id)
    # Do something
    delivery = Delivery.find(delivery_id)

    deliver( delivery ) if delivery.may_deliver?
  end

  private
    def deliver delivery
      sklad_product = SkladProduct.find_by( sklad_id: delivery.sklad_id, product_id: delivery.product_id )
      if sklad_product
        sklad_product.increment('quantify', delivery.quantify)
        sklad_product.update( delivery_last: DateTime.now )
      else
        sklad_product = SkladProduct.new( sklad_id: delivery.sklad_id, product_id: delivery.product_id, quantify: delivery.quantify, delivery_last: DateTime.now )
      end

      ActiveRecord::Base.transaction do
        sklad_product.save!
      end
      delivery.deliver!
    rescue StandardError => e
      delivery.fail!
    end
end
