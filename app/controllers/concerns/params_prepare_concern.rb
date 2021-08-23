module ParamsPrepareConcern
  def date_time product_id
    l = lambda { |o| params["delivery_dates"]["#{product_id}(#{o})"] }
    "#{l.('1i')}-#{l.('2i')}-#{l.('3i')} #{l.('4i')}:#{l.('5i')}:00"
  end

  def sklad_id
    params["sklad_id"].to_i
  end

  def quantify product_id
    params["quantify"]["#{product_id}"].to_i
  end
end