class BuyOneGetOneHalfPrice < Offer
  include ActiveModel::Model

  attr_reader :product_code

  validates :product_code, presence: true

  def initialize(product_code)
    @product_code = product_code
  end

  def apply(items)
    discount = 0.0
    red_widgets = items.select { |item| item.code == @product_code }

    if red_widgets.count >= 2
      discount = (red_widgets.first.price / 2.0).round(2)
    end

    discount
  end
end
