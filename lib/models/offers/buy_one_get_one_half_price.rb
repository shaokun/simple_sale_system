# frozen_string_literal: true

class BuyOneGetOneHalfPrice < Offer
  include ActiveModel::Model

  attr_reader :product_code

  validates :product_code, presence: true

  def initialize(product_code)
    super()
    @product_code = product_code
  end

  def apply(items)
    discount = 0.0
    red_widgets = items.select { |item| item.code == @product_code }

    discount = (red_widgets.first.price / 2.0).round(2) if red_widgets.count >= 2

    discount
  end
end
