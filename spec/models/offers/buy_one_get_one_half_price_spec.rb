RSpec.describe BuyOneGetOneHalfPrice do
  it "is valid with a product_code" do
    offer = BuyOneGetOneHalfPrice.new("R01")
    expect(offer).to be_valid
  end

  it "is invalid without a product_code" do
    offer = BuyOneGetOneHalfPrice.new(nil)
    expect(offer).to_not be_valid
    expect(offer.errors[:product_code]).to include("can't be blank")
  end
end