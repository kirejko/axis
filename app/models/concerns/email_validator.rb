# frozen_string_literal: true

require 'mail'

# Custom email validation
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    return false unless value.present?

    begin
      m = Mail::Address.new(value)
      r = m.domain.present? && m.domain.match('\.') && m.address == value
    rescue
      r = false
    end
    record.errors[attribute] << (options[:message] || 'is invalid') unless r
  end
end