# frozen_string_literal: true

class Basket
  attr_reader :product_catalogue, :delivery_charge_rules, :offers

  def initialize(product_catalogue:, delivery_charge_rules:, offers: [])
    validate_arguments!(product_catalogue, delivery_charge_rules, offers)

    @product_catalogue = product_catalogue
    @delivery_charge_rules = delivery_charge_rules
    @offers = offers
    @items = []
  end

  def add(product_code)
    raise ArgumentError, 'Product code cannot be nil or empty' if product_code.nil? || product_code.to_s.strip.empty?
    raise ArgumentError, "Product '#{product_code}' not found in catalogue" unless @product_catalogue.key?(product_code)

    @items << @product_catalogue.fetch(product_code)
  end

  def total
    subtotal = @items.sum(&:price)
    discount = @offers.sum { |offer| offer.apply(@items) }
    delivery_charge = @delivery_charge_rules.charge(subtotal - discount)
    (subtotal - discount + delivery_charge).round(2)
  end

  private

  def validate_arguments!(product_catalogue, delivery_charge_rules, offers)
    validate_product_catalogue!(product_catalogue)
    validate_delivery_charge_rules!(delivery_charge_rules)
    validate_offers!(offers)
  end

  def validate_product_catalogue!(product_catalogue)
    raise ArgumentError, 'Product catalogue cannot be nil' if product_catalogue.nil?

    return if product_catalogue.respond_to?(:key?) && product_catalogue.respond_to?(:fetch)

    raise ArgumentError, 'Product catalogue must respond to :key? and :fetch methods (e.g., Hash)'
  end

  def validate_delivery_charge_rules!(delivery_charge_rules)
    raise ArgumentError, 'Delivery charge rules cannot be nil' if delivery_charge_rules.nil?

    return if delivery_charge_rules.respond_to?(:charge)

    raise ArgumentError, 'Delivery charge rules must respond to :charge method'
  end

  def validate_offers!(offers)
    raise ArgumentError, 'Offers must be an enumerable collection (e.g., Array)' unless offers.is_a?(Array)

    offers.each_with_index do |offer, index|
      raise ArgumentError, "Offer at index #{index} must be an instance of Offer class" unless offer.is_a?(Offer)
    end
  end
end
