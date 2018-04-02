# Check is model presents in database
# Attribute name convert to CamelCase and uses as model name
class ExistsValidator < ActiveModel::EachValidator
  attr_reader :attribute

  def validate_each(record, attribute, value)
    @attribute ||= attribute
    db_entry = Kernel.const_get(camelized_class_name).find(value)

    if db_entry.present?
      record.instance_variable_set("@#{attribute}", db_entry)
    else
      record.errors[attribute] << (options[:message] || "The selected #{camelized_class_name} is invalid.")
    end
  end

  private

  def camelized_class_name
    attribute.to_s.camelize
  end
end
