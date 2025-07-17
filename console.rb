require 'pry'
require_relative './config/autoload'

# Acme Widget Co. Example
puts "\n--- Acme Widget Co. Basket Examples ---"

product_catalogue = {
  "R01" => Product.new("R01", "Red Widget", 32.95),
  "G01" => Product.new("G01", "Green Widget", 24.95),
  "B01" => Product.new("B01", "Blue Widget", 7.95)
}

Pry.start