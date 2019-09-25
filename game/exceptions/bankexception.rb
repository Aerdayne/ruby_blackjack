# frozen_string_literal: true

class BankException < StandardError
  def message
    'Your bank is empty.'
  end
end
