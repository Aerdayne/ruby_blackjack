# frozen_string_literal: true

# :nodoc:
module Validation
  module ClassMethods
    attr_reader :validators

    def validate(attribute, type, *args)
      raise CustomException, 'Attribute to be validated should be a symbol!' unless [attribute, type].all?(Symbol)

      @validators ||= []
      @validators << { attribute_name: attribute, validation_call: type, arguments: args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validators.each do |row|
        value = instance_variable_get("@#{row[:attribute_name]}")
        send row[:validation_call], row[:attribute_name], value, row[:arguments]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def includes(attribute, value, args)
      range = args[0]
      raise CustomException, "#{attribute} should be included in #{range}" unless range.include?(value)
    end
  end

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
end