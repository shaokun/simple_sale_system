require 'active_model'

class Product
  include ActiveModel::Model

  attr_reader :code, :name, :price

  validates :code, presence: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end
end
