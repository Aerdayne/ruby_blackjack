# frozen_string_literal: true

# :nodoc:
class BankException < CustomException
  def message
    'Your bank is empty.'
  end
end
