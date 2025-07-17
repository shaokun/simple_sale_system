class Basket
  include ActiveModel::Model

  attr_reader :product_catalogue, :delivery_charge_rules, :offers

  validates :product_catalogue, presence: true
  validates :delivery_charge_rules, presence: true

  def initialize(product_catalogue, delivery_charge_rules, offers = [])
    @product_catalogue = product_catalogue
    @delivery_charge_rules = delivery_charge_rules
    @offers = offers
    @items = []
  end

  def add(product_code)
    @items << @product_catalogue.fetch(product_code)
  end

  def total
    subtotal = @items.sum(&:price)
    discount = @offers.sum { |offer| offer.apply(@items) }
    delivery_charge = @delivery_charge_rules.charge(subtotal - discount)
    (subtotal - discount + delivery_charge).round(2)
  end
end
