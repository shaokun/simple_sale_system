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

  subject(:basket) { described_class.new(product_catalogue, delivery_charge_rules, offers) }

  it "is valid with valid attributes" do
    expect(basket).to be_valid
  end

  it "is invalid without a product_catalogue" do
    basket = described_class.new(nil, delivery_charge_rules, offers)
    expect(basket).to_not be_valid
    expect(basket.errors[:product_catalogue]).to include("can't be blank")
  end

  it "is invalid without delivery_charge_rules" do
    basket = described_class.new(product_catalogue, nil, offers)
    expect(basket).to_not be_valid
    expect(basket.errors[:delivery_charge_rules]).to include("can't be blank")
  end

  context "with delivery charges and offers" do
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