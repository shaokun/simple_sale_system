RSpec.describe Basket do
  let(:product_catalogue) do
    {
      "R01" => Product.new(code: "R01", name: "Red Widget", price: 32.95),
      "G01" => Product.new(code: "G01", name: "Green Widget", price: 24.95),
      "B01" => Product.new(code: "B01", name: "Blue Widget", price: 7.95)
    }
  end

  let(:delivery_charge_rules) { DeliveryChargeRules }
  let(:offers) { [BuyOneGetOneHalfPrice.new("R01")] }

  subject(:basket) { described_class.new(product_catalogue: product_catalogue, delivery_charge_rules: delivery_charge_rules, offers: offers) }

  describe "#initialize" do
    it "creates a basket with valid attributes" do
      expect(basket.product_catalogue).to eq(product_catalogue)
      expect(basket.delivery_charge_rules).to eq(delivery_charge_rules)
      expect(basket.offers).to eq(offers)
    end

    it "raises ArgumentError when product_catalogue is nil" do
      expect {
        described_class.new(product_catalogue: nil, delivery_charge_rules: delivery_charge_rules, offers: offers)
      }.to raise_error(ArgumentError, "Product catalogue cannot be nil")
    end

    it "raises ArgumentError when product_catalogue doesn't respond to required methods" do
      expect {
        described_class.new(product_catalogue: "invalid", delivery_charge_rules: delivery_charge_rules, offers: offers)
      }.to raise_error(ArgumentError, "Product catalogue must respond to :key? and :fetch methods (e.g., Hash)")
    end

    it "raises ArgumentError when delivery_charge_rules is nil" do
      expect {
        described_class.new(product_catalogue: product_catalogue, delivery_charge_rules: nil, offers: offers)
      }.to raise_error(ArgumentError, "Delivery charge rules cannot be nil")
    end

    it "raises ArgumentError when delivery_charge_rules doesn't respond to charge" do
      expect {
        described_class.new(product_catalogue: product_catalogue, delivery_charge_rules: "invalid", offers: offers)
      }.to raise_error(ArgumentError, "Delivery charge rules must respond to :charge method")
    end

    it "raises ArgumentError when offers is nil" do
      expect {
        described_class.new(product_catalogue: product_catalogue, delivery_charge_rules: delivery_charge_rules, offers: nil)
      }.to raise_error(ArgumentError, "Offers cannot be nil (use empty array instead)")
    end

    it "raises ArgumentError when offers is not enumerable" do
      expect {
        described_class.new(product_catalogue: product_catalogue, delivery_charge_rules: delivery_charge_rules, offers: "invalid")
      }.to raise_error(ArgumentError, "Offers must be an enumerable collection (e.g., Array)")
    end

    it "raises ArgumentError when an offer doesn't respond to apply" do
      invalid_offer = Object.new
      expect {
        described_class.new(product_catalogue: product_catalogue, delivery_charge_rules: delivery_charge_rules, offers: [invalid_offer])
      }.to raise_error(ArgumentError, "Offer at index 0 must respond to :apply method")
    end

    it "allows empty offers array" do
      expect {
        described_class.new(product_catalogue: product_catalogue, delivery_charge_rules: delivery_charge_rules, offers: [])
      }.not_to raise_error
    end

    it "uses empty array as default for offers when not provided" do
      basket = described_class.new(product_catalogue: product_catalogue, delivery_charge_rules: delivery_charge_rules)
      expect(basket.offers).to eq([])
    end
  end

  describe "#add" do
    it "raises ArgumentError when product_code is nil" do
      expect {
        basket.add(nil)
      }.to raise_error(ArgumentError, "Product code cannot be nil or empty")
    end

    it "raises ArgumentError when product_code is empty string" do
      expect {
        basket.add("")
      }.to raise_error(ArgumentError, "Product code cannot be nil or empty")
    end

    it "raises ArgumentError when product_code is whitespace" do
      expect {
        basket.add("   ")
      }.to raise_error(ArgumentError, "Product code cannot be nil or empty")
    end

    it "raises ArgumentError when product is not in catalogue" do
      expect {
        basket.add("INVALID")
      }.to raise_error(ArgumentError, "Product 'INVALID' not found in catalogue")
    end

    it "successfully adds valid product" do
      expect { basket.add("R01") }.not_to raise_error
    end
  end

  context "total calculations with delivery charges and offers" do
    it "calculates the total for B01, G01" do
      basket.add("B01")
      basket.add("G01")
      expect(basket.total).to eq(37.85)
    end

    it "calculates the total for R01, R01" do
      basket.add("R01")
      basket.add("R01")
      expect(basket.total).to eq(54.37)
    end

    it "calculates the total for R01, G01" do
      basket.add("R01")
      basket.add("G01")
      expect(basket.total).to eq(60.85)
    end

    it "calculates the total for B01, B01, R01, R01, R01" do
      basket.add("B01")
      basket.add("B01")
      basket.add("R01")
      basket.add("R01")
      basket.add("R01")
      expect(basket.total).to eq(98.27)
    end
  end
end