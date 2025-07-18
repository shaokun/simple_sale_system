# frozen_string_literal: true

class Product
  include ActiveModel::Model
  attr_accessor :code, :name, :price

  validates :code, presence: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
