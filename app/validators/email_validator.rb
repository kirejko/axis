# frozen_string_literal: true

# Custom email validation
class EmailValidator < ActiveModel::EachValidator

  ALLOWED_DOMAINS = {
      email: ['amgrade.com'],
      gmail: ['gmail.com']
  }.freeze

  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid) unless value.match?(Devise.email_regexp) && valid_domain(attribute, value)
  end

  def valid_domain(attribute, value)
    ALLOWED_DOMAINS[attribute].include?(value.split('@')[1])
  end

end