require 'pry'
require_relative './config/autoload'

# Acme Widget Co. Example
puts "\n--- Acme Widget Co. Basket Examples ---"

product_catalogue = {
  "R01" => Product.new(code: "R01", name: "Red Widget", price: 32.95),
  "G01" => Product.new(code: "G01", name: "Green Widget", price: 24.95),
  "B01" => Product.new(code: "B01", name: "Blue Widget", price: 7.95)
}

delivery_charge_rules = DeliveryChargeRules
offers = [BuyOneGetOneHalfPrice.new("R01")]

# Example 1: B01, G01
basket1 = Basket.new(product_catalogue:, delivery_charge_rules:, offers:)
basket1.add("B01")
basket1.add("G01")
puts "Basket 1 (B01, G01) total: $#{basket1.total}"

# Example 2: R01, R01
basket2 = Basket.new(product_catalogue:, delivery_charge_rules:, offers:)
basket2.add("R01")
basket2.add("R01")
puts "Basket 2 (R01, R01) total: $#{basket2.total}"

# Example 3: R01, G01
basket3 = Basket.new(product_catalogue:, delivery_charge_rules:, offers:)
basket3.add("R01")
basket3.add("G01")
puts "Basket 3 (R01, G01) total: $#{basket3.total}"

# Example 4: B01, B01, R01, R01, R01
basket4 = Basket.new(product_catalogue:, delivery_charge_rules:, offers:)
basket4.add("B01")
basket4.add("B01")
basket4.add("R01")
basket4.add("R01")
basket4.add("R01")
puts "Basket 4 (B01, B01, R01, R01, R01) total: $#{basket4.total}"

Pry.start