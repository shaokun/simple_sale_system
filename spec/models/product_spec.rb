# frozen_string_literal: true

RSpec.describe Product do
  it 'is valid with a code, name, and price' do
    product = described_class.new(code: 'R01', name: 'Red Widget', price: 32.95)
    expect(product).to be_valid
  end

  it 'is invalid without a code' do
    product = described_class.new(name: 'Red Widget', price: 32.95)
    expect(product).not_to be_valid
    expect(product.errors[:code]).to include("can't be blank")
  end

  it 'is invalid without a name' do
    product = described_class.new(code: 'R01', price: 32.95)
    expect(product).not_to be_valid
    expect(product.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a price' do
    product = described_class.new(code: 'R01', name: 'Red Widget')
    expect(product).not_to be_valid
    expect(product.errors[:price]).to include("can't be blank")
  end

  it 'is invalid with a non-numeric price' do
    product = described_class.new(code: 'R01', name: 'Red Widget', price: 'abc')
    expect(product).not_to be_valid
    expect(product.errors[:price]).to include('is not a number')
  end

  it 'is invalid with a negative price' do
    product = described_class.new(code: 'R01', name: 'Red Widget', price: -10.0)
    expect(product).not_to be_valid
    expect(product.errors[:price]).to include('must be greater than or equal to 0')
  end
end
