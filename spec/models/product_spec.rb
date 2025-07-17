RSpec.describe Product do
  it "is valid with a code, name, and price" do
    product = Product.new("R01", "Red Widget", 32.95)
    expect(product).to be_valid
  end

  it "is invalid without a code" do
    product = Product.new(nil, "Red Widget", 32.95)
    expect(product).to_not be_valid
    expect(product.errors[:code]).to include("can't be blank")
  end

  it "is invalid without a name" do
    product = Product.new("R01", nil, 32.95)
    expect(product).to_not be_valid
    expect(product.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a price" do
    product = Product.new("R01", "Red Widget", nil)
    expect(product).to_not be_valid
    expect(product.errors[:price]).to include("can't be blank")
  end

  it "is invalid with a non-numeric price" do
    product = Product.new("R01", "Red Widget", "abc")
    expect(product).to_not be_valid
    expect(product.errors[:price]).to include("is not a number")
  end

  it "is invalid with a negative price" do
    product = Product.new("R01", "Red Widget", -10.0)
    expect(product).to_not be_valid
    expect(product.errors[:price]).to include("must be greater than or equal to 0")
  end
end