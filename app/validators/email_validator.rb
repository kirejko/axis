# frozen_string_literal: true

# Custom email validation
class EmailValidator < ActiveModel::EachValidator

  MY_OPTIONS = { domains: [] }.freeze

  def check_validity!
    options.slice(*MY_OPTIONS.keys).each do |option, value|
      next if value.is_a?(Array)
      raise ArgumentError, "#{option} must be an array of domains"
    end
  end

  def validate_each(record, attribute, value)
    unless value.match?(Devise.email_regexp)
      record.errors.add(attribute, :invalid, options)
      return
    end

    if options.key?(:domains)
      unless valid_domain?(value)
        record.errors.add(attribute, :disallowed_domain, options)
      end
    end
  end

  private

  def valid_domain?(value)
    options[:domains].include?(value.split('@')[1])
  end

end