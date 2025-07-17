class DeliveryChargeRules
  def self.charge(subtotal)
    if subtotal < 50
      4.95
    elsif subtotal < 90
      2.95
    else
      0.0
    end
  end
end
