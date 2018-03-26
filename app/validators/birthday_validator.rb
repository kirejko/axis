# frozen_string_literal: true

class BirthdayValidator < ActiveModel::EachValidator

  MY_OPTS = { min_age: 18.years.ago }.freeze

  def check_validity!
    options.slice(*MY_OPTS.keys).each do |option, value|
      next if value.is_a?(ActiveSupport::Duration)
      raise ArgumentError, "#{option} must be an age like 18.years.ago"
    end
  end

  def validate_each(record, attribute, value)
    value = Time.parse(value)
    # value = value.to_datetime if value.is_a?(ActiveSupport::TimeWithZone)

    unless value
      record.errors.add(attribute, :not_a_date, options)
      return
    end

    unless is_time?(value)
      record.errors.add(attribute, :not_a_date, options)
    end

    if options.key?(:min_age)
      unless value < options[:min_age]
        record.errors.add(attribute, :too_young, options)
      end
    end

  end

  private

  def is_time?(object)
    object.is_a?(Time) || (defined?(ActiveSupport::TimeWithZone) and object.is_a?(ActiveSupport::TimeWithZone))
  end

end