class MakeDeliveryWorker
  include Sidekiq::Worker

  def perform(delivery_id)
    # Do something
    product = Delivery.find(delivery_id)

    
    if product.may_deliver?
      if product.deliver! 

    end
  end

  private
    def 
      
    end
end