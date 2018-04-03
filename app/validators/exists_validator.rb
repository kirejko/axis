# Check is model presents in database
# Attribute name convert to CamelCase and uses as model name
class ExistsValidator < ActiveModel::EachValidator
  attr_reader :attribute, :value

  def validate_each(record, attribute, value)
    @attribute ||= attribute
    @value     ||= value

    db_entry = Kernel.const_get(camelized_class_name).find(entry_id)

    if db_entry.present?
      record.instance_variable_set("@#{attribute}", db_entry) unless value.is_a? ApplicationRecord
    else
      record.errors[attribute] << (options[:message] || "The selected #{camelized_class_name} is invalid.")
    end
  end

  private

  def camelized_class_name
    attribute.to_s.camelize
  end

  def entry_id
    if value.is_a? ApplicationRecord
      value.id
    else
      value
    end
  end
end
