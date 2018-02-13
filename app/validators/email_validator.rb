# frozen_string_literal: true

# Custom email validation
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid) unless value.match?(Devise.email_regexp)
  end
end