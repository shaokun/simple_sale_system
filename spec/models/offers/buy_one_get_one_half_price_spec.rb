# frozen_string_literal: true

RSpec.describe BuyOneGetOneHalfPrice do
  it 'is valid with a product_code' do
    offer = described_class.new('R01')
    expect(offer).to be_valid
  end

  it 'is invalid without a product_code' do
    offer = described_class.new(nil)
    expect(offer).not_to be_valid
    expect(offer.errors[:product_code]).to include("can't be blank")
  end
end
