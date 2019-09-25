# frozen_string_literal: true

# Hand limit exception
class HandException < StandardError
  def message
    'You can not hit with 3 cards!'
  end
end
