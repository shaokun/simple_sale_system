# frozen_string_literal: true

class Offer
  def apply(items)
    raise NotImplementedError, 'Subclasses must implement the apply method.'
  end
end
