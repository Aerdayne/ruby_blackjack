# frozen_string_literal: true

# :nodoc
class DrainedException < CustomException
  def message
    'Deck has been drained.'
  end
end
